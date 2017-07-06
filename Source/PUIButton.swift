//
//  PureUI
//  PUIButton.swift
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//

import UIKit

enum GradientPosition {
    case top
    case bottom
    case left
    case right
}

enum IndicatorPosition {
    case left
    case right
    case center
}

enum PBType {
    case A
    case B
    case C
    case D
}

@IBDesignable
public class PUIButton: UIButton {
    
    
    private var gradientLayer:CAGradientLayer!
    private var loaderIndicator:UIActivityIndicatorView!
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        reset()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        reset()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func reset() {
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    // Title
    @IBInspectable var title:String = "hello!" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    // Title Color
    @IBInspectable var titleColor:UIColor = UIColor.black {
        didSet {
            self.setTitleColor(titleColor, for: .normal)
        }
    }
    // Background Color
    @IBInspectable var bgColor:UIColor = UIColor.lightGray.withAlphaComponent(0.3) {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    // Button İmage
    @IBInspectable var img:UIImage? = nil {
        didSet {
            self.setImage(img, for: .normal)
        }
    }
    
    // Border Width
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    // Border Color
    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    // Corner Radius
    @IBInspectable var radius:CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    // Mask to Bounds
    @IBInspectable var maskBounds:Bool = false {
        didSet {
            self.layer.masksToBounds = maskBounds
        }
    }
    
    // Clips to Bounds
    @IBInspectable var clipsBounds:Bool = false {
        didSet {
            self.clipsToBounds = clipsBounds
        }
    }
    
    // Shadow Color
    @IBInspectable var shadowColor:UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    // Shadow Offset
    @IBInspectable var shadowOffset:CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    // Shadow Radius
    @IBInspectable var shadowRadius:CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    // Shadow Opacity
    @IBInspectable var shadowOpacity:Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    // Gradient Button
    func setGradient(first:String, end:String, state:GradientPosition) {
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor().hexx(first),UIColor().hexx(end)]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        if case state = GradientPosition.top {
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        } else if case state = GradientPosition.bottom {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        } else if case state = GradientPosition.left {
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        } else if case state = GradientPosition.right {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }
        
        self.layer.addSublayer(gradientLayer)
    }
    
    // Indicator Set
    func setIndicator(style:UIActivityIndicatorViewStyle,position:IndicatorPosition,scale:CGFloat?) {
        
        self.isEnabled = false
        
        loaderIndicator = UIActivityIndicatorView()
        loaderIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        loaderIndicator.center = self.center
        loaderIndicator.hidesWhenStopped = true
        loaderIndicator.activityIndicatorViewStyle = style
        loaderIndicator.startAnimating()
        
        if scale != nil {
            if scale! > 0.0 {
                loaderIndicator.transform = CGAffineTransform.init(scaleX: scale!, y: scale!)
            }
        }
        
        self.addSubview(loaderIndicator)
        
        loaderIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        var xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: loaderIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: loaderIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        
        if case position = IndicatorPosition.center {
            
            self.setTitle("", for: .normal)
            xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: loaderIndicator, attribute: .centerX, multiplier: 1, constant: 0)
            
        } else if case position = IndicatorPosition.left {
            
            xCenterConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: loaderIndicator, attribute: .left, multiplier: 1, constant: -(self.frame.size.width / 8))
            
        } else if case position = IndicatorPosition.right {
            xCenterConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: loaderIndicator, attribute: .right, multiplier: 1, constant: (self.frame.size.width / 8))
        }
        
        self.addConstraints([xCenterConstraint, yCenterConstraint])
    }
    
    // Remove Indicator
    func removeIndicator() {
        
        if loaderIndicator.isAnimating {
            self.setTitle(title, for: .normal)
            self.isEnabled = true
            loaderIndicator.stopAnimating()
            loaderIndicator.removeFromSuperview()
        }
    }
    
    // Title Top edge
    @IBInspectable var titleTopEdge:CGFloat = 0 {
        didSet {
            self.titleEdgeInsets = UIEdgeInsetsMake(titleTopEdge, titleLeftEdge, titleBottomEdge, titleRightEdge)
        }
    }
    
    // Title Left edge
    @IBInspectable var titleLeftEdge:CGFloat = 0 {
        didSet {
            self.titleEdgeInsets = UIEdgeInsetsMake(titleTopEdge, titleLeftEdge, titleBottomEdge, titleRightEdge)
        }
    }
    
    // Title Right edge
    @IBInspectable var titleRightEdge:CGFloat = 0 {
        didSet {
            self.titleEdgeInsets = UIEdgeInsetsMake(titleTopEdge, titleLeftEdge, titleBottomEdge, titleRightEdge)
        }
    }
    
    // Title Bottom edge
    @IBInspectable var titleBottomEdge:CGFloat = 0 {
        didSet {
            self.titleEdgeInsets = UIEdgeInsetsMake(titleTopEdge, titleLeftEdge, titleBottomEdge, titleRightEdge)
        }
    }
    
    // Content Top edge
    @IBInspectable var contentTopEdge:CGFloat = 0 {
        didSet {
            self.contentEdgeInsets = UIEdgeInsetsMake(contentTopEdge, contentLeftEdge, contentBottomEdge, contentRightEdge)
        }
    }
    // Content Left edge
    @IBInspectable var contentLeftEdge:CGFloat = 0 {
        didSet {
            self.contentEdgeInsets = UIEdgeInsetsMake(contentTopEdge, contentLeftEdge, contentBottomEdge, contentRightEdge)
        }
    }
    // Content Right edge
    @IBInspectable var contentRightEdge:CGFloat = 0 {
        didSet {
            self.contentEdgeInsets = UIEdgeInsetsMake(contentTopEdge, contentLeftEdge, contentBottomEdge, contentRightEdge)
        }
    }
    // Content Bottom edge
    @IBInspectable var contentBottomEdge:CGFloat = 0 {
        didSet {
            self.contentEdgeInsets = UIEdgeInsetsMake(contentTopEdge, contentLeftEdge, contentBottomEdge, contentRightEdge)
        }
    }
    
    // Button types
    func setButtonStyle(type:PBType) {
        
        switch (type) {
        case .A:
            self.borderWidth = 1
            self.borderColor = UIColor().colorHex("#58D3F7")
            self.titleColor = UIColor().colorHex("#58D3F7")
            self.titleLabel?.font = UIFont(name: "Avenir-Next", size: 20)
            self.radius = 15
            self.bgColor = UIColor.clear
        case .B:
            self.backgroundColor = UIColor().colorHex("#58D3F7")
            self.borderWidth = 3
            self.borderColor = UIColor().colorHex("#58D3F7")
            self.titleColor = UIColor.white
            self.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
            self.shadowOffset = CGSize(width: 0, height: 4)
            self.shadowRadius = 0.3
            self.shadowOpacity = 0.9
            self.shadowColor = UIColor().colorHex("#4CAFCE")
        case .C:
            self.backgroundColor = UIColor().colorHex("#58D3F7")
            self.radius = 0
            self.borderWidth = 3
            self.borderColor = UIColor().colorHex("#58D3F7")
            self.titleColor = UIColor.white
            self.titleLabel?.font = UIFont(name: "PingFangTC-Light", size: 20)
            self.shadowOffset = CGSize(width: 5, height: 5)
            self.shadowRadius = 0.3
            self.shadowOpacity = 0.9
            self.shadowColor = UIColor().colorHex("#4CAFCE")
        case .D:
            self.backgroundColor = UIColor().colorHex("#58D3F7")
            self.radius = 3
            self.borderWidth = 0
            self.titleColor = UIColor.white
            self.titleLabel?.font = UIFont(name: "Symbol", size: 20)
            self.shadowOffset = CGSize(width: 3, height: 3)
            self.shadowRadius = 12
            self.shadowOpacity = 3
            self.shadowColor = UIColor().colorHex("#4398B2")
        }
    }
    

}//


