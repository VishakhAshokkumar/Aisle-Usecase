//
//  PhoneNumberAuthView.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit

class PhoneNumberAuthView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get OTP"
        label.font = .interLight(size: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Your Phone Number"
        label.font = .interBold(size: 30)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryCodeField: UITextField = {
        let textField = UITextField()
        textField.text = "+91"
        textField.isUserInteractionEnabled = false
        textField.font = .interBold(size: 18)
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneNumberField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter 10-digit number"
        textField.keyboardType = .numberPad
        textField.font = .interBold(size: 18)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = UIColor.systemYellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .interBold(size: 18)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(countryCodeField)
        addSubview(phoneNumberField)
        addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            countryCodeField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            countryCodeField.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryCodeField.widthAnchor.constraint(equalToConstant: 60),
            countryCodeField.heightAnchor.constraint(equalToConstant: 44),
            
            phoneNumberField.leadingAnchor.constraint(equalTo: countryCodeField.trailingAnchor, constant: 12),
            phoneNumberField.trailingAnchor.constraint(equalTo: trailingAnchor),
            phoneNumberField.centerYAnchor.constraint(equalTo: countryCodeField.centerYAnchor),
            phoneNumberField.heightAnchor.constraint(equalToConstant: 44),
            
            continueButton.topAnchor.constraint(equalTo: countryCodeField.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 130),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor) // Ensures view resizes with content
        ])
    }
}



// Padding helper
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
