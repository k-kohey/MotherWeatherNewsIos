import UIKit

class Font {
    enum FontSize: CGFloat {
        case plain = 14.0
        case middle = 16.0
        case big = 24.0
        case impact = 82.0
    }
    
    static func plainFont(of size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
    }

    static func englishFont(of size: FontSize) -> UIFont {
        return UIFont(name: "Helvetica", size: size.rawValue)!
    }

    static func boldFont(of size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
    }
}
