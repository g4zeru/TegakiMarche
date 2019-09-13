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
    var imageAspectRatio: CGFloat {
        get {
            return PicturePreview.aspectRatio(size: self.imageView.frame.size)
        }
        set {
            if newValue == PicturePreview.aspectRatio(size: self.imageView.frame.size) {
                return
            }
            scrollView.maximumZoomScale = newValue > 1 ? newValue : 1 / newValue
            imageView.snp.remakeConstraints { (maker) in
                maker.edges.equalToSuperview()
                if newValue > 1 {
                    maker.width.equalToSuperview()
                    maker.height.equalTo(self.snp.width).multipliedBy(CGFloat(1) / newValue)
                } else if newValue < 1 {
                    maker.height.equalToSuperview()
                    maker.width.equalTo(self.snp.height).multipliedBy(newValue)
                } else {
                    maker.width.equalToSuperview()
                    maker.height.equalToSuperview()
                }
            }
            layoutIfNeeded()
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
    
    static func aspectRatio(size: CGSize) -> CGFloat {
        return size.width / size.height
    }
}

