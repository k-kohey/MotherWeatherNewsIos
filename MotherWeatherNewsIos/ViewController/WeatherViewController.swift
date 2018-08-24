import UIKit
import SnapKit
import LTMorphingLabel
import SwiftyGif

import RxSwift

class WeatherViewController: UIViewController {
    var firstOpen = true
    var disposeBag: DisposeBag = DisposeBag()

    let containerView = UIView()

    var backgroundImageView: UIImageView = {
        let gif = UIImage(gifName: "b1.gif")
        let imageview = UIImageView(gifImage: gif, loopCount: -1)
        return imageview
    }()

    var nameLabel: UILabel = {
        let label = UILabel().white().center()
        label.font = Font.plainFont(of: .big)
        label.textColor = .white
        return label
    }()

    var weatherConditionLabel: UILabel = {
        let label = UILabel().white().center()
        label.font = Font.plainFont(of: .plain)
        return label
    }()

    var degreeLabel: LTMorphingLabel = {
        let label = LTMorphingLabel()
        label.textColor = .white
        label.textAlignment = .center
        label.morphingEffect = .pixelate
        label.font = Font.englishFont(of: .impact)
        return label
    }()

    var separetorView: UIView = {
        let view = UIView()
        let separaor = UIView()
        separaor.backgroundColor = .white
        view.addSubview(separaor)
        separaor.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        return view
    }()

    var paramLabels: [LTMorphingLabel] = {
        var labels: [LTMorphingLabel] = []
        for _ in WeatherType.allcases {
            let label = LTMorphingLabel()
            label.textColor = .white
            label.textAlignment = .center
            label.text = "0"
            label.morphingEffect = .pixelate
            labels.append(label)
        }
        return labels
    }()

    var weatherImageView = WeatherImageView()

    var chigichanCommentView = ChigichanCommentView()

    struct Const {
        static let contentTopMargin = 80.0
        static let smallConntentMargin = 3.0
        static let middleConntentMargin = 9.0
        static let bigContentMargin = 15.0
        static let layoutMargin = 16.0
        static let separetorLength = 125.0
        static let paramsMargin = 35.0
        static let chigichanHeight = 100.0
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        bind()
    }

    func setupView() {
        view.addSubview(backgroundImageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(weatherConditionLabel)
        containerView.addSubview(degreeLabel)
        containerView.addSubview(separetorView)
        for i in WeatherType.allcases {
            containerView.addSubview(paramLabels[i.rawValue])
        }
        containerView.addSubview(weatherImageView)
        view.addSubview(chigichanCommentView)

        nameLabel.text = "MOTHER"
        weatherConditionLabel.text = "ところにより曇り"
        degreeLabel.text = "24°"
    }

    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.left.equalTo(Const.layoutMargin)
            $0.bottom.right.equalTo(-Const.layoutMargin)
        }

        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Const.contentTopMargin)
            $0.centerX.equalToSuperview()
        }

        weatherConditionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Const.smallConntentMargin)
            $0.left.right.equalToSuperview()
        }

        degreeLabel.snp.makeConstraints {
            $0.top.equalTo(weatherConditionLabel.snp.bottom).offset(Const.middleConntentMargin)
            $0.centerX.equalToSuperview().offset(10.0)
        }

        paramLabels[0].snp.makeConstraints {
            $0.top.equalTo(separetorView.snp.bottom).offset(Const.middleConntentMargin)
            $0.centerX.equalTo(paramLabels[1]).offset(-Const.paramsMargin)
        }

        paramLabels[1].snp.makeConstraints {
            $0.top.equalTo(paramLabels[0])
            $0.centerX.equalToSuperview().offset(-Const.paramsMargin / 2)
        }

        paramLabels[2].snp.makeConstraints {
            $0.top.equalTo(paramLabels[0])
            $0.centerX.equalToSuperview().offset(Const.paramsMargin / 2)
        }

        paramLabels[3].snp.makeConstraints {
            $0.top.equalTo(paramLabels[0])
            $0.centerX.equalTo(paramLabels[2]).offset(Const.paramsMargin)
        }

        separetorView.snp.makeConstraints {
            $0.top.equalTo(degreeLabel.snp.bottom).offset(Const.smallConntentMargin)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(paramLabels[0])
            $0.trailing.equalTo(paramLabels[3])
            $0.height.equalTo(1.0)
        }

        weatherImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(Const.bigContentMargin)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(separetorView).dividedBy(1.4)
            $0.height.equalTo(separetorView.snp.width).dividedBy(1.4)
        }

        chigichanCommentView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(5.0)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(Const.chigichanHeight)
        }
    }

    func bind() {
        self.subscribeAPI()
        Observable<Int>.interval(10, scheduler: MainScheduler.instance).subscribe({_ in
            self.subscribeAPI()
        }).disposed(by: self.disposeBag)
    }

    private func subscribeAPI() {
        API.request(to: .weather).subscribe(
            onSuccess: { entity in
                guard let data = entity.data else {return}
                self.weatherImageView.type = data.type ?? .sunny
                self.degreeLabel.text = "\(data.temperature)°"
                let gif = UIImage(gifName: "b\(data.type?.rawValue ?? 0).gif")
                self.backgroundImageView.gifImage = gif
                for (i, label) in self.paramLabels.enumerated() {
                    label.text = "\(data.weather_rates[i])"
                }
                self.weatherConditionLabel.text = data.condition
                self.chigichanCommentView.discriptionLabel.text = data.advice
        }, onError: { error in
            print(error)
        }).disposed(by: self.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UILabel {
    func white() -> UILabel{
        self.textColor = .white
        return self
    }

    func center() -> UILabel{
        self.textAlignment = .center
        return self
    }
}
