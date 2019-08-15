//
//  Extension-UIImageView.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/15.
//

import UIKit

extension UIImageView {
    func setImage(url: URL) {
        self.image = nil
        let session = URLSession.shared
        session.dataTask(with: url) { ( data, _, error) in
            if let error = error {
                debugPrint(error)
            } else if let data = data {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.image = UIImage(data: data)
                })
            }
        }
    }
}
