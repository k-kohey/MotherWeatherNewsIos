import UIKit

class WeatherImageView: UIImageView {
    convenience init(type: WeatherType) {
        let image = UIImage(named: "w\(type.rawValue)")
        self.init(image: image)
    }

    convenience init() {
        self.init(image: UIImage())
    }

    override init(image: UIImage?) {
        super.init(image: image)
        contentMode = .scaleAspectFit
        alpha = 0.9
    }

    func setImage(type: WeatherType) {
        let newImage = UIImage(named: "w\(type.rawValue)")
        toggleAnimate {_ in
            self.image = newImage
            self.toggleAnimate(compeltion: { _ in})
        }
    }

    func toggleAnimate(compeltion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.6, animations: {self.alpha = 1.0 - self.alpha}, completion: compeltion)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
