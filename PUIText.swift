//
//  PureUI
//  PUIText.swift
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//

import UIKit


@IBDesignable
public class PUIText: UITextField {
    
    private var bottomFrame:CALayer = CALayer()
    private var placeholderAttrStr:NSMutableAttributedString!
    private var spaceView:UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
      super.layoutSubviews()
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
    // Left padding text
    @IBInspectable var leftPadding:CGFloat = 0 {
        didSet {
            let paddingView = UIView()
            paddingView.frame = CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height)
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    }
    // Right padding text
    @IBInspectable var rightPadding:CGFloat = 0 {
        didSet {
            let paddingView = UIView()
            paddingView.frame = CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.height)
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    // Bottom border set
    @IBInspectable var onlyBottomBorder:Bool = false {
        didSet {
            if onlyBottomBorder {
                spaceView.backgroundColor = UIColor.clear
                bottomFrame.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 2)
                bottomFrame.backgroundColor = UIColor.red.cgColor
                self.borderStyle = .none
                self.layer.addSublayer(bottomFrame)
            }
        }
    }
    // Bottom border width
    @IBInspectable var bottomWidth:CGFloat = 2.0 {
        didSet {
            bottomFrame.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: bottomWidth)
        }
    }
    // Bottom border color
    @IBInspectable var bottomColor:UIColor = UIColor.red {
        didSet {
            bottomFrame.backgroundColor = bottomColor.cgColor
        }
    }
    
    // Left imageview set
    @IBInspectable var leftImage:UIImage? = nil {
        didSet {
            
                let contentView:UIView = UIView()
                contentView.frame = CGRect(x: 0, y: 0, width: 44, height: self.frame.height)
                contentView.backgroundColor = UIColor.clear
                spaceView = UIView()
                spaceView.backgroundColor = UIColor().colorHex("#F3F3F3")
                spaceView.frame = CGRect(x: 0, y: 0, width: 40, height: self.frame.height)
                let leftImgView = UIImageView()
                leftImgView.frame = CGRect(x: spaceView.frame.width / 2 - 12, y: spaceView.frame.height / 2 - 12, width: 24, height: 24)
                leftImgView.image = leftImage
                spaceView.addSubview(leftImgView)
                contentView.addSubview(spaceView)
                self.leftView = contentView
                self.leftViewMode = .always
        }
    }
    // Right imageview set
    @IBInspectable var rightImage:UIImage? = nil {
        didSet {
 
            let contentView:UIView = UIView()
            contentView.frame = CGRect(x: 0, y: 0, width: 44, height: self.frame.height)
            contentView.backgroundColor = UIColor.clear
            spaceView = UIView()
            spaceView.backgroundColor = UIColor().colorHex("#F3F3F3")
            spaceView.frame = CGRect(x: 4, y: 0, width: 40, height: self.frame.height)
            let rightImgView = UIImageView()
            rightImgView.frame = CGRect(x: spaceView.frame.width / 2 - 12, y: spaceView.frame.height / 2 - 12, width: 24, height: 24)
            rightImgView.image = rightImage
            spaceView.addSubview(rightImgView)
            contentView.addSubview(spaceView)
            self.rightView = contentView
            self.rightViewMode = .always

        }
    }
    // ImageView background color
    @IBInspectable var imageColor:UIColor = UIColor().colorHex("#F3F3F3") {
        didSet {
            spaceView.backgroundColor = imageColor
        }
    }
    // Placeholder
    @IBInspectable var placeholderText:String = "" {
        didSet {
            placeholderAttrStr = NSMutableAttributedString(string: placeholderText, attributes: [NSFontAttributeName: UIFont(name: "Avenir", size: 15)!])
            placeholderAttrStr.addAttributes([NSForegroundColorAttributeName: UIColor.lightGray.withAlphaComponent(0.7)], range: NSRange(location: 0,length: placeholderText.characters.count))
            self.attributedPlaceholder = placeholderAttrStr
        }
    }
    // Placeholder color
    @IBInspectable var placeholderColor:UIColor = UIColor.lightGray.withAlphaComponent(0.8) {
        didSet {
            placeholderAttrStr.addAttributes([NSForegroundColorAttributeName: placeholderColor], range: NSRange(location: 0, length: placeholderText.characters.count))
            self.attributedPlaceholder = placeholderAttrStr
        }
    }
    // Placeholder font
    var placeholderFont:UIFont = UIFont(name: "Avenir", size: 18)! {
        didSet {
            placeholderAttrStr.addAttributes([NSFontAttributeName: placeholderFont], range: NSRange(location: 0, length: placeholderText.characters.count))
            self.attributedPlaceholder = placeholderAttrStr
        }
    }
    
 
    
}//
