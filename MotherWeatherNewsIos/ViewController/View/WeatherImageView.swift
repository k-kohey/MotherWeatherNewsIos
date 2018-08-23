import UIKit

class WeatherImageView: UIImageView {
    var type: WeatherType = .sunny{
        willSet {
            if type != newValue {
                setImage(type: newValue)
            }
        }
    }

    convenience init() {
        self.init(image: UIImage())
    }

    override init(image: UIImage?) {
        super.init(image: UIImage(named:"w\(0)"))
        contentMode = .scaleAspectFit
        alpha = 0.9
    }

    private func setImage(type: WeatherType) {
        let newImage = UIImage(named: "w\(type.rawValue)")
        toggleAnimate {_ in
            self.image = newImage
            self.toggleAnimate(compeltion: { _ in})
        }
    }

    func toggleAnimate(compeltion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.4, animations: {self.alpha = 1.0 - self.alpha}, completion: compeltion)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
