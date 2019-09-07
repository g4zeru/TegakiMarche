//
//  UserDetailsViewController.swift
//  TegakiMarche
//
//  Created by iniad on 2019/08/16.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet private weak var optionButton: UIButton!
    @IBOutlet private weak var optionButtonOverlayView: UIView!
    @IBOutlet private weak var firstButton: BottomBorderButton!
    @IBOutlet private weak var secondButton: BottomBorderButton!
    @IBOutlet private weak var firstCollectionView: UICollectionView!

    init() {
        super.init(nibName: "UserDetailsViewController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.optionButtonOverlayView.layer.masksToBounds = false
        self.optionButtonOverlayView.layer.cornerRadius = 10
        self.optionButtonOverlayView.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.optionButtonOverlayView.layer.shadowRadius = 3
        self.optionButtonOverlayView.layer.shadowOpacity = 0.2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstButton.borderHeight = 2
        self.firstButton.borderColor = UIColor.darkGray.cgColor
        self.secondButton.borderHeight = 2
        self.secondButton.borderColor = UIColor.lightGray.cgColor
    }
}
