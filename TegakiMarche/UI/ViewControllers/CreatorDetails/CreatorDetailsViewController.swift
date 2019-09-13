// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 17:30.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit

class CreatorDetailsViewController: UIViewController, UIScrollViewDelegate {
    let image: UIImage
    
    @IBOutlet weak var contentView: PicturePreview!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let mock: [(String, UIImage)] = [("ゴーストルール", UIImage(named: "ゴーストルール")!), ("ゴーストルール", UIImage(named: "ゴーストルール")!), ("ゴーストルール", UIImage(named: "ゴーストルール")!)]
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: "CreatorDetailsViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        self.scrollView.delegate = self
        self.navigationItem.title = "愛言葉Ⅲ"
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
Music: DECO*27
Illust: 八三

CD: https://www.amazon.co.jp/dp/B07PT7CJ22…
iTunes:https://music.apple.com/jp/album/%E6%…
Pixiv: https://www.pixiv.net/member_illust.php…
"""))
        let otherview = OtherItemSectionView()
        otherview.collectionView.dataSource = self
        otherview.collectionView.delegate = self
        verticalStackView.addArrangedSubview(otherview)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.imageAspectRatio = PicturePreview.aspectRatio(size: image.size)
        contentView.updateInset()
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

extension CreatorDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mock.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MusicContentCollectionViewCell.dequeue(from: collectionView, for: indexPath)
        cell.contentLabel.text = mock[indexPath.item].0
        cell.contentImageView.image = mock[indexPath.item].1
        return cell
    }
}

extension CreatorDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
