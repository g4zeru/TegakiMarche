// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 17:30.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate

class ContentDetailsViewController: UIViewController, UIScrollViewDelegate, NibType, NibInstantiatable {
    let image: UIImage = UIImage(named: "demo")!
    
    @IBOutlet weak var contentView: PicturePreview!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let mock: [(String, UIImage)] = [("ゴーストルール", UIImage(named: "demo1")!), ("ゴーストルール", UIImage(named: "demo2")!), ("ゴーストルール", UIImage(named: "demo3")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.scrollView.delegate = self
        self.navigationItem.title = "TegakiMarche"
        self.navigationController?.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       
        contentView.image = image
        let audioView = AudioControlView.instantiate()
        verticalStackView.addArrangedSubview(audioView)
        audioView.snp.makeConstraints { (maker) in
            maker.height.equalTo(200)
        }
        verticalStackView.addArrangedSubview(DetailTextView.instantiate(with: """
Music: Terany
Illust: g4zeru

CD: https://www.amazon.co.jp/dp/B07PT7CJ22…
iTunes:https://music.apple.com/jp/album/%E6%…
Pixiv: https://www.pixiv.net/member_illust.php…
"""))
        let otherview = RelatedItemsView(type: .audio, contentSize: CGSize(width: 130, height: 130))
        otherview.contents.accept(mock)
        verticalStackView.addArrangedSubview(otherview)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.contentView.updateFrame()
        self.contentView.updateInset()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }
}
