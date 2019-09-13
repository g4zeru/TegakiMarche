// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: TegakiMarche.
// CreatedAt: 17:40.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import Instantiate

class AudioControlView: UIView, NibInstantiatable {
    @IBOutlet weak var playTimeSeekSlider: UISlider!
    @IBOutlet weak var volumeSeekSlider: UISlider!
    func inject(_ dependency: ()) {
        let volumeThumbImg = UIColor.white.circleImage(size: CGSize(width: 20, height: 20))
        volumeSeekSlider.setThumbImage(volumeThumbImg, for: .normal)
        let timeThumbImg = UIColor.white.circleImage(size: CGSize(width: 13, height: 13))
        playTimeSeekSlider.setThumbImage(timeThumbImg, for: .normal)
        
    }
}

extension UIColor {
    func circleImage(size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.setStrokeColor(UIColor.darkGray.cgColor)
        context?.fillEllipse(in: rect)
        context?.strokeEllipse(in: CGRect(x: 1, y: 1, width: size.width - 2, height: size.height - 2))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}
