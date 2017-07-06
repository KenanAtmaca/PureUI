import UIKit


extension UIColor {
    func colorHex(_ rgb:String) -> UIColor {
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        if rgb.hasPrefix("#") {
            
            let hex:String = rgb.replacingOccurrences(of: "#", with: "")
            let scanner = Scanner(string: hex)
            var hexval:CUnsignedLongLong = 0
            
            if scanner.scanHexInt64(&hexval) {
                
                red = CGFloat((hexval & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexval & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexval & 0x0000FF) / 255.0
                
                
            }else {
                fatalError("@Scan error")
            }
            
        }else {
            fatalError("@Need # in parameter!")
        }
        
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return color
        
    }
    
    func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor as AnyObject
    }
    
    func hexx(_ str:String) -> AnyObject {
        return UIColor().colorHex(str).cgColor as AnyObject
    }
    
}
