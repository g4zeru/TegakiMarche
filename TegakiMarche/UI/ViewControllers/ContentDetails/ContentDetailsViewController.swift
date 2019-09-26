// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 17:30.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate
import RxSwift
import RxCocoa

protocol ContentDetailsViewControllerProtocol {
    var stackContents: [UIView] { get }
    func insertStackContent(view: UIView, at: Int)
    func removeStackContent(view: UIView)
    func updateImage(_ image: UIImage?)
}

class ContentDetailsViewController: UIViewController, UIScrollViewDelegate, NibType, NibInstantiatable, ContentDetailsViewControllerProtocol {
    ///contentViewが存在しない場合もあるが、それは想定外エラーなのでその場合は処理落ちさせる。
    ///なるべくcontentViewが存在しない場合をなくすためにテストを重点的に記述する
    var stackContents: [UIView] {
        return verticalStackView.arrangedSubviews
    }
    
    @IBOutlet weak var contentView: PicturePreview!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var store: ContentDetailsStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updateImage(_ image: UIImage?) {
        contentView.image = image
        contentView.updateFrame()
        contentView.updateInset()
    }
    
    func insertStackContent(view: UIView, at: Int = 0) {
        verticalStackView.insertArrangedSubview(view, at: at)
    }
    func removeStackContent(view: UIView) {
        verticalStackView.removeArrangedSubview(view)
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }
}
