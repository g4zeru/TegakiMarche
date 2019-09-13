// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 19:35.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import RxSwift
import RxRelay

class RelatedItemsView: UIView {
    enum ContentType {
        case audio
        case picture
    }
    let contents: BehaviorRelay<[(String, UIImage)]> = .init(value: [])
    private let contentsType: ContentType
    private let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.registerNib(type: MusicContentCollectionViewCell.self)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return view
    }()
    
    private let contentSize: CGSize
    
    init(title: String = "", type: ContentType, frame: CGRect = .zero, contentSize: CGSize = .zero) {
        self.contentsType = type
        self.contentSize = contentSize
        super.init(frame:frame)
        self.titleLabel.text = title
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(10)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
        }
        self.collectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-10)
            maker.height.equalTo(contentSize.height + 10)
        }
    }
}

extension RelatedItemsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MusicContentCollectionViewCell.dequeue(from: collectionView, for: indexPath, with:  contents.value[indexPath.item])
        return cell
    }
}

extension RelatedItemsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.contentsType == .audio ? contentSize : CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
