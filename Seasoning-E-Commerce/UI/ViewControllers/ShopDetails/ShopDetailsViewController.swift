//
//  ShopDetailsViewController.swift
//  Seasoning-E-Commerce
//
//  Created by iniad on 2019/08/17.
//

import UIKit

class ShopDetailsViewController: UIViewController {
    @IBOutlet private weak var contentStackView: UIStackView!
    @IBOutlet private weak var headerOverlayView: UIView!
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var shopNameLabel: UILabel!
    @IBOutlet private weak var shopIconImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
