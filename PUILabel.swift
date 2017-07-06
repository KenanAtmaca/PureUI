//
//  PureUI
//  PUILabel.swift
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//

import UIKit

@IBDesignable
public class PUILabel: UILabel {
    
    private var bottomFrame = CALayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
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
 
    // Bottom border
    @IBInspectable var bottomBorder:Bool = false {
        didSet {
            borderWidth = 0
            bottomFrame.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
            bottomFrame.backgroundColor = UIColor.red.cgColor
            self.layer.addSublayer(bottomFrame)
        }
    }
    
    // Bottom border width
    @IBInspectable var bWidth:CGFloat = 1 {
        didSet {
            bottomFrame.frame.size = CGSize(width: self.frame.width, height: bWidth)
        }
    }
    
    // Left border
    @IBInspectable var leftBorder:Bool = false {
        didSet {
            borderWidth = 0
            bottomFrame.frame = CGRect(x: 1, y: 0, width: 1, height: self.frame.height)
            bottomFrame.backgroundColor = UIColor.red.cgColor
            self.layer.addSublayer(bottomFrame)
        }
    }
    
    // Left border width
    @IBInspectable var lWidth:CGFloat = 1 {
        didSet {
           bottomFrame.frame = CGRect(x: 1, y: 0, width: lWidth, height: self.frame.height)
        }
    }
    
    // Bottom & Left border color
    @IBInspectable var blColor:UIColor = UIColor.red {
        didSet {
            bottomFrame.backgroundColor = blColor.cgColor
        }
    }
    
    // Set Padding
    public override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: lWidth + 5, bottom: 0, right: 0)
        self.setNeedsLayout()
        return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    
}//
