//
//  OTPView.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit

class OTPAuthView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interLight(size: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.isUserInteractionEnabled = true // for tap gesture
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter The OTP"
        label.font = .interBold(size: 30)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let otpTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter OTP"
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

    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "01:00"
        label.font = .interBold(size: 16)
        label.textColor = .black
        label.textAlignment = .right
        label.isUserInteractionEnabled = true // make tappable
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(otpTextField)
        addSubview(continueButton)
        addSubview(timerLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            otpTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            otpTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            otpTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            otpTextField.heightAnchor.constraint(equalToConstant: 44),


            continueButton.topAnchor.constraint(equalTo: otpTextField.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 130),
            continueButton.heightAnchor.constraint(equalToConstant: 50),

            timerLabel.leadingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: 20),
            timerLabel.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor),


            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // Add edit icon to title label
        let pencilImage = UIImage(systemName: "pencil")
        let attachment = NSTextAttachment(image: pencilImage!)
        let fullText = NSMutableAttributedString(string: titleLabel.text ?? "")
        fullText.append(NSAttributedString(attachment: attachment))
        titleLabel.attributedText = fullText

        // Tap gesture for editing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editTapped))
        titleLabel.addGestureRecognizer(tapGesture)
    }
    
    func setPhoneNumber(_ number: String) {
        let pencilImage = UIImage(systemName: "pencil")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = pencilImage

        let attributedText = NSMutableAttributedString(string: number + "  ")
        attributedText.append(NSAttributedString(attachment: imageAttachment))
        
        titleLabel.attributedText = attributedText
    }


    @objc private func editTapped() {
        NotificationCenter.default.post(name: .didTapEditPhoneNumber, object: nil)
    }
}



extension Notification.Name {
    static let didTapEditPhoneNumber = Notification.Name("didTapEditPhoneNumber")
}

