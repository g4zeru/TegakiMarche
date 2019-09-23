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
    func showError(text: String)
}

class ContentDetailsViewController: UIViewController, UIScrollViewDelegate, NibType, NibInstantiatable {
    
    typealias Dependency = Firebase.Content
    
    @IBOutlet weak var contentView: PicturePreview!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private(set) var content: Firebase.Content! = nil
    
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
        self.contentView.updateFrame()
        self.contentView.updateInset()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func inject(_ dependency: Firebase.Content) {
        self.content = dependency
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }
}
