// 
// Copyright: © 2019, g4zeru All Rights Reserved.
// Target: Seasoning-E-Commerce.
// CreatedAt: 1:14.
// GitHub: https://github.com/g4zeru/Seasoning-E-Commerce
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional
import FirebaseAuth

class CreateShopViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: CustomTouchStackView!
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            self.nameTextField.rx.text.asObservable().map { $0 ?? "" }.bind(to: self.viewModel.input.name).disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            self.descriptionTextView.rx.text.asObservable().map { $0 ?? "" }.bind(to: self.viewModel.input.description).disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.rx.text.asObservable().map { $0 ?? "" }.bind(to: self.viewModel.input.email).disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var emailSwitchView: UISwitch! {
        didSet {
            self.emailSwitchView.rx.isOn.asObservable().bind(to: self.viewModel.input.isCurrentEmail).disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var nameLimitLabel: UILabel!
    @IBOutlet weak var descriptionLimitLabel: UILabel!
    @IBOutlet weak var emailWarningLabel: UILabel!
    @IBOutlet weak var currentEmailAddressLabel: UILabel!
    
    
    let viewModel: CreateShopViewModelType = CreateShopViewModel()
    
    private static let nameLimit: Int = 15
    private static let descriptionLimit: Int = 150
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: "CreateShopViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "お店を開業する"
        bind()
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
    }
    
    func bind() {
        emailSwitchView.rx.isOn.bind(to: self.emailTextField.rx.isHidden).disposed(by: disposeBag)
        nameTextField.rx.text.asObservable()
            .map { $0 ?? "" }
            .map { CreateShopViewController.nameLimit - $0.count }
            .subscribe(onNext: { [weak self] (count) in
                if 0 <= count {
                    self?.nameLimitLabel.textColor = UIColor.darkGray
                } else {
                    self?.nameLimitLabel.textColor = UIColor.red
                }
                self?.nameLimitLabel.text = String(count)
            })
            .disposed(by: disposeBag)
        
        descriptionTextView.rx.text.asObservable()
            .map { $0 ?? "" }
            .map { CreateShopViewController.descriptionLimit - $0.count }
            .subscribe(onNext: { [weak self] (count) in
                if 0 <= count {
                    self?.descriptionLimitLabel.textColor = UIColor.darkGray
                } else {
                    self?.descriptionLimitLabel.textColor = UIColor.red
                }
                self?.descriptionLimitLabel.text = String(count)
            })
            .disposed(by: disposeBag)
        
        emailSwitchView.rx.isOn
            .subscribe(onNext: { [weak self] (isOn) in
                guard let self = self else { return }
                self.currentEmailAddressLabel.isHidden = !isOn
                self.emailTextField.isHidden = isOn
                
            })
            .disposed(by: disposeBag)
        
        viewModel.output.prepareEmail
            .bind(to: emailWarningLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        stackView.touches
            .subscribe(onNext: { [weak self] _ in
                if self?.viewModel.output.showsKeyboard.value ?? false {
                    self?.view.endEditing(true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            print(true)
            textField.resignFirstResponder()
            self.descriptionTextView.becomeFirstResponder()
        }
        return true
    }
}
