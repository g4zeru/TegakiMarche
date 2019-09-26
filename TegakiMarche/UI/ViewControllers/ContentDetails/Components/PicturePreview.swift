// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 15:02.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate

class PicturePreview: UIView, UIScrollViewDelegate {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.bouncesZoom = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.minimumZoomScale = 1
        view.maximumZoomScale = 2
        view.backgroundColor = UIColor.black
        return view
    }()
    private let overlayView = UIView()
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private var imageAspectRatio: CGFloat {
        get {
            ///本来なら画像がない場合0を返したいが、0徐算が発生する可能性があるため1を返す
            return self.imageView.image != nil ? self.imageView.image!.size.width / self.imageView.image!.size.height : 1
        }
    }
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.imageView.image = nil
        self.addSubview(scrollView)
        self.scrollView.addSubview(imageView)
        self.scrollView.delegate = self
        self.scrollView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.top.equalToSuperview()
        }
        self.imageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
    }
    
    func updateFrame() {
        let ratio = image?.aspectRatio ?? 1
        scrollView.maximumZoomScale = ratio > 1 ? ratio : 1 / ratio
        imageView.snp.remakeConstraints { (maker) in
            maker.edges.equalToSuperview()
            if ratio > 1 {
                maker.width.equalToSuperview()
                maker.height.equalTo(self.snp.width).multipliedBy(1 / ratio)
            } else if ratio < 1 {
                maker.height.equalToSuperview()
                maker.width.equalTo(self.snp.height).multipliedBy(ratio)
            } else {
                maker.width.equalToSuperview()
                maker.height.equalToSuperview()
            }
        }
        layoutIfNeeded()
    }
    
    func updateInset() {
        let vertical: CGFloat = scrollView.frame.height <= imageView.frame.height ? 0.5 : ((scrollView.frame.height - imageView.frame.height) / 2) + 0.5
        let horizontal: CGFloat = scrollView.frame.width <= imageView.frame.width ? 0.5 : ((scrollView.frame.width - imageView.frame.width) / 2) + 0.5
        scrollView.contentInset = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateInset()
    }
}

