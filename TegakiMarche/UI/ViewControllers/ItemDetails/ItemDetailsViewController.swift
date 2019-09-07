//
//  ItemDetailsViewController.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/15.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    enum AdditionalContent {
        case headline(String)
        case subHeadline(String)
        case text(String)
        case image(URL)
        case button
    }

    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var optionsWrapView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var purchaseButton: UIButton!
    @IBOutlet private weak var purchaseButtonOverlayView: UIView!
    @IBOutlet private weak var additionalContentsStackView: UIStackView!

    let item: Firebase.Item

    var additionalContents: [AdditionalContent] = {
        var content = [AdditionalContent]()
        content.append(.headline("おすすめの食べ方"))
        content.append(.subHeadline("餃子"))
        content.append(.text( "淡口醤油と餃子の組み合わせは大いにおすすめです。お酢で餃子を食べるのが好きな方は多いと思いますが、酢を引き立てた酢醤油という印象です。さっぱり食べたい方にも。"))
        content.append(.subHeadline("天ぷら"))
        content.append(.text( "カラッと揚がりサクサクの天ぷらを楽しむことができます。その上ヘルシーに仕上がるのでカロリーを気にせず食べられます。"))
        content.append(.subHeadline("ししゃもフライ"))
        content.append(.text( "フライでもおいしいししゃも。旬の11～12月のししゃもは卵がぎっしりとつまっていてうま味たっぷり。揚げ物ですが、大きさもちょうど良くサクッと食べられるので思いのほかたくさん食べちゃった、なんてことも。"))
        content.append(.button)
        return content
    }()

    var paragraphStyle: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = 5
        return style
    }

    init(item: Firebase.Item) {
        self.item = item
        super.init(nibName: "ItemDetailsViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        super.loadView()
        self.purchaseButtonOverlayView.layer.cornerRadius = 10
        self.purchaseButtonOverlayView.layer.masksToBounds = false
        self.purchaseButtonOverlayView.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.purchaseButtonOverlayView.layer.shadowRadius = 3
        self.purchaseButtonOverlayView.layer.shadowOpacity = 0.3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateContents()
        self.updateAdditionalContents(contents: self.additionalContents)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.optionsWrapView.layer.cornerRadius = self.optionsWrapView.frame.height / 2
    }

    func updateContents() {
        self.titleLabel.attributedText = NSAttributedString(string: item.title, attributes: attributes(fontSize: 20, lineSpacing: 10, isBold: true))
        self.descriptionLabel.attributedText = NSAttributedString(string: item.desc, attributes: attributes(fontSize: 15, lineSpacing: 12))
        self.priceLabel.text = "¥" + item.price.separatedByThreeDigitsWithComma
        //self.rateLabel.text = String(item.rate)
    }

    func updateAdditionalContents(contents: [AdditionalContent]) {
        self.removeAllAdditionalContents()
        contents.forEach { content in
            self.additionalContentsStackView.addArrangedSubview(generateAdditionalContentView(content: content))
        }
    }

    func removeAllAdditionalContents() {
        self.additionalContentsStackView.arrangedSubviews.forEach { [weak self] subview in
            self?.additionalContentsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }

    func generateAdditionalContentView(content: AdditionalContent) -> UIView {
        switch content {
        case .image(let image):
            return AdditionalContentImageView(image: image)

        case .text(let text):
            return AdditionalContentTextView(text: text)

        case .headline(let text):
            return AdditionalContentHeadlineView(text: text)

        case .subHeadline(let text):
            return AdditionalContentSubHeadlineView(text: text)

        case .button:
            return AdditionalContentPurchaseButtonView()
        }
    }

    func attributes(
        fontSize: CGFloat,
        lineSpacing: CGFloat = 0,
        isBold: Bool = false,
        alignment: NSTextAlignment = .left,
        textColor: UIColor = .darkGray,
        backgroundColor: UIColor = .clear
        ) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()
        let paragraphStyle: NSMutableParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            style.lineSpacing = lineSpacing
            return style
        }()
        attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        attributes.updateValue(isBold ? UIFont.hiraginoW6(size: fontSize) : UIFont.hiraginoW3(size: fontSize),
                               forKey: .font)
        attributes.updateValue(textColor, forKey: .foregroundColor)
        attributes.updateValue(backgroundColor, forKey: .backgroundColor)
        return attributes
    }
}
