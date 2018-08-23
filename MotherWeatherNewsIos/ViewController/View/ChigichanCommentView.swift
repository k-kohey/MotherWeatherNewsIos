import UIKit

class ChigichanCommentView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel().white().center()
        label.text = "ちぎちゃん１言アドバイス"
        label.font = Font.boldFont(of: .plain)
        return label
    }()

    let discriptionLabel: UILabel = {
        let label = UILabel().white()
        label.numberOfLines = -1
        label.font = Font.plainFont(of: .plain)
        label.text = "絶好調でやんす!!!!!!!!!!!!!!!!"
        label.textAlignment = .center
        return label
    }()

    let backgroundView = UIView()

    struct Const {
        static let layoutMargin = 16.0
        static let contentMargin = 8.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    func setupView() {
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.3
        backgroundView.layer.masksToBounds = true
        layer.cornerRadius = 5.0
        layer.masksToBounds = true

        addSubview(backgroundView)
        addSubview(titleLabel)
        addSubview(discriptionLabel)
    }

    func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Const.layoutMargin)
            $0.height.equalToSuperview().dividedBy(5)
            $0.centerX.equalToSuperview()
        }

        discriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Const.contentMargin)
            $0.left.right.equalToSuperview().inset(Const.layoutMargin)
            $0.bottom.equalToSuperview().inset(Const.layoutMargin + 5.0)
        }
    }
}
