import UIKit

extension UIColor {

    static let primaryColor =  UIColor(red: 0.75, green: 0.21, blue: 0.05, alpha: 1.0)
    static let primaryDarkTextColor = UIColor.rgb(red: 66, green: 66, blue: 66)
    static let primaryLighTextColor = UIColor.rgb(red: 109, green: 109, blue: 109)
    static let accentColor = UIColor(red:0.73, green:0.25, blue:0.23, alpha:1.0)
    static let veryLightGray = UIColor.rgb(red: 235, green: 235, blue: 235)
    
    
    public static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
