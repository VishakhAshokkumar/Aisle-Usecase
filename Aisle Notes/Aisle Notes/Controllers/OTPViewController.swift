//
//  OTPViewController.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit

class OTPViewController: UIViewController {
    
    private let otpView = OTPAuthView()
    private var viewModel: OTPViewModel!
    
    var phoneNumber: String = ""  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        viewModel = OTPViewModel(phoneNumber: phoneNumber)
        
        setupOTPView()
        bindViewModel()
        
        viewModel.startTimer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(editPhoneNumberTapped), name: .didTapEditPhoneNumber, object: nil)
    }
    
    private func setupOTPView() {
        view.addSubview(otpView)
        otpView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            otpView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            otpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            otpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        otpView.setPhoneNumber(phoneNumber)
        otpView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        let resendTap = UITapGestureRecognizer(target: self, action: #selector(resendCodeTapped))
        otpView.timerLabel.addGestureRecognizer(resendTap)
        otpView.timerLabel.isUserInteractionEnabled = false
    }
    
    private func bindViewModel() {
        viewModel.onTimerUpdate = { [weak self] seconds in
            DispatchQueue.main.async {
                let minutes = seconds / 60
                let secs = seconds % 60
                self?.otpView.timerLabel.text = String(format: "%02d:%02d", minutes, secs)
                self?.otpView.timerLabel.textColor = .black
                self?.otpView.timerLabel.isUserInteractionEnabled = false
            }
        }

        viewModel.onTimerFinished = { [weak self] in
            DispatchQueue.main.async {
                self?.otpView.timerLabel.text = "Resend Code"
                self?.otpView.timerLabel.textColor = .systemBlue
                self?.otpView.timerLabel.isUserInteractionEnabled = true
            }
        }

        viewModel.onOTPValidationResult = { [weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    // Fetch notes after OTP success
                    self?.viewModel.fetchDataForNotesTab()
                } else if let message = errorMessage {
                    self?.showAlert(message: message)
                }
            }
        }

        viewModel.onOTPSent = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(message: "OTP has been resent.")
            }
        }

        viewModel.onNotesFetched = { [weak self] notes in
            DispatchQueue.main.async {
                let mainTabBarVC = MainTabBarViewController()
                mainTabBarVC.configure(with: notes) 
                mainTabBarVC.modalPresentationStyle = .fullScreen
                self?.present(mainTabBarVC, animated: true)
            }
        }


        viewModel.onNotesFetchFailed = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(message: errorMessage)
            }
        }
    }

    
    @objc private func continueTapped() {
        let otp = otpView.otpTextField.text
        viewModel.validateOTP(otp)
    }
    
    @objc private func resendCodeTapped() {
        viewModel.resendOTP()
    }
    
    @objc private func editPhoneNumberTapped() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in completion?() })
        present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
