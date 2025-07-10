//
//  OTPViewModel.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import Foundation

final class OTPViewModel {

    private var timer: Timer?
    private(set) var remainingSeconds: Int = 60 {
        didSet {
            onTimerUpdate?(remainingSeconds)
        }
    }
    
    let phoneNumber: String
    private var authToken: String?

    // Callbacks for UI updates
    var onTimerUpdate: ((Int) -> Void)?
    var onTimerFinished: (() -> Void)?
    var onOTPSent: (() -> Void)?
    var onOTPValidationResult: ((Bool, String?) -> Void)?
    var onNotesFetched: ((NotesResponse) -> Void)?
    var onNotesFetchFailed: ((String) -> Void)?
    
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    
    func startTimer() {
        stopTimer()
        
        remainingSeconds = 60
        onTimerUpdate?(remainingSeconds)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerTick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerTick() {
        remainingSeconds -= 1
        if remainingSeconds <= 0 {
            stopTimer()
            onTimerFinished?()
        }
    }
    
    
    func validateOTP(_ otp: String?) {
        guard let otp = otp, otp.count == 4, otp.allSatisfy({ $0.isNumber }) else {
            onOTPValidationResult?(false, "Please enter a valid 4-digit OTP")
            return
        }
        
        Task {
            do {
                let response = try await NetworkManager.shared.verifyOTP(phoneNumber: phoneNumber, otp: otp)
                if let token = response.token, !token.isEmpty {
                    self.authToken = token
                    onOTPValidationResult?(true, nil)
                } else {
                    onOTPValidationResult?(false, "Invalid OTP. Please try again.")
                }
            } catch {
                onOTPValidationResult?(false, "Network error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func resendOTP() {
        Task {
            do {
                let _ = try await NetworkManager.shared.login(with: phoneNumber)
                onOTPSent?()
                startTimer()
            } catch {
                onOTPValidationResult?(false, "Failed to resend OTP: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Fetch Notes Data
    
    func fetchDataForNotesTab() {
        guard let token = authToken else {
            onNotesFetchFailed?("Auth token is missing. Please verify OTP first.")
            return
        }
        
        Task {
            do {
                let notesResponse = try await NetworkManager.shared.fetchNotes(authToken: token)
                onNotesFetched?(notesResponse)
            } catch {
                onNotesFetchFailed?("Failed to fetch notes: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Cleanup
    
    deinit {
        stopTimer()
    }
}
