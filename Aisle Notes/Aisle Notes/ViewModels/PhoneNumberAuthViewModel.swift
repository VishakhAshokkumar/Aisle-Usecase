//
//  PhoneNumberAuthViewModel.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import Foundation

final class PhoneNumberAuthViewModel {

    var phoneNumber: String = "" {
        didSet {
            isPhoneNumberValid = validatePhoneNumber(phoneNumber)
        }
    }

    private(set) var isPhoneNumberValid: Bool = false

    var onLoadingStateChange: ((Bool) -> Void)?
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func continueTapped() {
        guard isPhoneNumberValid else {
            onError?("Please enter a valid 10-digit phone number.")
            return
        }
        
        Task {
            await loginUser()
        }
    }

    private func loginUser() async {
        onLoadingStateChange?(true)
        do {
            let fullPhoneNumber = "+91" + phoneNumber
            let response = try await NetworkManager.shared.login(with: fullPhoneNumber)
            onLoadingStateChange?(false)

            if response.status {
                onSuccess?()
            } else {
                onError?("Failed to send OTP. Please try again.")
            }
        } catch {
            print("Login failed: \(error.localizedDescription)")
            onLoadingStateChange?(false)
            onError?("Failed to send OTP. Please try again.")
        }
    }



    private func validatePhoneNumber(_ number: String) -> Bool {
        return number.count == 10 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: number))
    }
}

