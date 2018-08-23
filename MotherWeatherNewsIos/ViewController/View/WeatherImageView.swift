import UIKit

class WeatherImageView: UIImageView {
    convenience init(type: Weather) {
        let image = UIImage(named: "w\(type.rawValue)")
        self.init(image: image)
    }

    convenience init() {
        self.init(image: UIImage())
        setImage(type: .sunny)
    }

    override init(image: UIImage?) {
        super.init(image: image)
        contentMode = .scaleAspectFit
        alpha = 0.9
    }

    func setImage(type: Weather) {
        image = UIImage(named: "w\(type.rawValue)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
