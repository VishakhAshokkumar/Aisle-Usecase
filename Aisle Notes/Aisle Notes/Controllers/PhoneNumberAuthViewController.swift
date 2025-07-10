//
//  PhoneNumberAuthViewController.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit

class PhoneNumberAuthViewController: UIViewController {
    
    private let inputViewContainer: PhoneNumberAuthView = {
        let view = PhoneNumberAuthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel = PhoneNumberAuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindViewModel()
        inputViewContainer.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside) 
    }

    
    private func setupLayout() {
        view.addSubview(inputViewContainer)
        
        NSLayoutConstraint.activate([
            inputViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            inputViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            inputViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func bindViewModel() {
        inputViewContainer.phoneNumberField.addTarget(self, action: #selector(phoneNumberChanged), for: .editingChanged)

        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.inputViewContainer.continueButton.isEnabled = !isLoading
                self?.inputViewContainer.continueButton.setTitle(isLoading ? "Loading..." : "Continue", for: .normal)
            }
        }

        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let otpVC = OTPViewController()
                otpVC.phoneNumber = "+91" + self.viewModel.phoneNumber
                
                self.navigationController?.pushViewController(otpVC, animated: true)
            }
        }


        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }

    @objc private func phoneNumberChanged() {
        viewModel.phoneNumber = inputViewContainer.phoneNumberField.text ?? ""
        inputViewContainer.continueButton.isEnabled = viewModel.isPhoneNumberValid
        inputViewContainer.continueButton.alpha = viewModel.isPhoneNumberValid ? 1.0 : 0.5
    }

    @objc private func continueTapped() {
        viewModel.continueTapped()
    }

}


