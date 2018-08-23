import UIKit

class Font {
    enum Size: CGFloat {
        case plain = 14.0
        case middle = 16.0
        case big = 24.0
        case impact = 82.0
    }

    func plainFont(of size: Size) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
    }

    func englishFont(of size: Size) -> UIFont {
        return UIFont(name: "Helvetica", size: size.rawValue)!
    }

    func boldFont(of size: Size) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
    }
}
