//
//  Extension-UIImage.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/14.
//

import UIKit

extension UIImage {
    class var heartSquareIcon: UIImage {
        return UIImage(named: "heart-square-icon")!.withRenderingMode(.alwaysTemplate)
    }
    var aspectRatio: CGFloat {
        return self.size.width / self.size.height
    }
    
    class func fetchImage(url: URL, completion: @escaping (Result<UIImage, Error>)->Void) {
        let session = URLSession.shared
        session.dataTask(with: url) {  data, _, error in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                if let error = error {
                    developDebugPrint(error)
                    completion(.failure(NetworkError.request))
                } else if let data = data {
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    } else {
                        developDebugPrint("failure data convert to UIImage... \(data)")
                        completion(.failure(NetworkError.dataParse))
                    }
                }

            }
        }.resume()
    }
}
