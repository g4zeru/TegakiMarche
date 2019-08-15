//
//  ItemDetailsViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    let item: Item
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
    
    var additionalContents: [AdditionalContent] = {
        var content = [AdditionalContent]()
        content.append(.title("餃子"))
        content.append(.text( "淡口醤油と餃子の組み合わせは大いにおすすめです。お酢で餃子を食べるのが好きな方は多いと思いますが、酢を引き立てた酢醤油という印象です。さっぱり食べたい方にも。"))
        content.append(.image(URL(string: "https://s-shoyu.com/img/color/re/720/218.jpg")!))
        content.append(.title("天ぷら"))
        content.append(.text( "カラッと揚がりサクサクの天ぷらを楽しむことができます。その上ヘルシーに仕上がるのでカロリーを気にせず食べられます。"))
        content.append(.image(URL(string: "https://www.tokyo-midtown.com/jp/restaurants/upload/thumb/2016/12/3F_9_main2-thumb-655xauto-920.jpg")!))
        content.append(.title("ししゃもフライ"))
        content.append(.text( "フライでもおいしいししゃも。旬の11～12月のししゃもは卵がぎっしりとつまっていてうま味たっぷり。揚げ物ですが、大きさもちょうど良くサクッと食べられるので思いのほかたくさん食べちゃった、なんてことも。"))
        content.append(.image(URL(string: "https://s-shoyu.com/img/color/re/720/015.jpg")!))
        content.append(.button)
        return content
    }()
    
    enum AdditionalContent {
        case title(String)
        case text(String)
        case image(URL)
        case button
    }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: "ItemDetailsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateAdditionalContents(contents: self.additionalContents)
        // Do any additional setup after loading the view.
    }
    
    func updateAdditionalContents(contents: [AdditionalContent]) {
        self.removeAllAdditionalContents()
        contents.forEach { (content) in
            self.additionalContentsStackView.addArrangedSubview(generateAdditionalContentView(content: content))
        }
        print(self.additionalContentsStackView.arrangedSubviews.count)
        
    }
    
    func removeAllAdditionalContents() {
        self.additionalContentsStackView.arrangedSubviews.forEach { [weak self] (subview) in
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
        case .title(let header):
            return AdditionalContentHeaderView(text: header)
        case .button:
            return AdditionalContentPurchaseButtonView()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
