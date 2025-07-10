//
//  NetworkManager.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}


// This is made for mocking when doing Unit Testing anytime

protocol NetworkService {
    func login(with phoneNumber: String) async throws -> PhoneNumberResponse
    func verifyOTP(phoneNumber: String, otp: String) async throws -> OTPResponse
    func fetchNotes(authToken: String) async throws -> NotesResponse
}

// MARK: - Network Manager

final class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://app.aisle.co/V1"
    
    //MARK: Public API Calls (From Protocol)
    
    func login(with phoneNumber: String) async throws -> PhoneNumberResponse {
        let url = try makeURL(path: "/users/phone_number_login")
        let body = try makeJSONBody(["number": phoneNumber])
        return try await performRequest(
            url: url,
            method: .post,
            body: body,
            headers: ["Content-Type": "application/json"],
            response: PhoneNumberResponse.self
        )
    }
    
    func verifyOTP(phoneNumber: String, otp: String) async throws -> OTPResponse {
        let url = try makeURL(path: "/users/verify_otp")
        let body = try makeJSONBody(["number": phoneNumber, "otp": otp])
        return try await performRequest(
            url: url,
            method: .post,
            body: body,
            headers: ["Content-Type": "application/json"],
            response: OTPResponse.self
        )
    }
    
    func fetchNotes(authToken: String) async throws -> NotesResponse {
        let url = try makeURL(path: "/users/test_profile_list")
        return try await performRequest(
            url: url,
            method: .get,
            body: nil,
            headers: ["Authorization": authToken],
            response: NotesResponse.self
        )
    }
    
    
    
    //MARK: Generic class for all HTTP methods
    
    private func performRequest<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        body: Data?,
        headers: [String: String]?,
        response: T.Type
    ) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.timeoutInterval = 30
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8) ?? "Invalid response string")
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
    //MARK: Helper class
    
    private func makeURL(path: String) throws -> URL {
        guard let url = URL(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        return url
    }
    
    private func makeJSONBody(_ dictionary: [String: Any]) throws -> Data {
        return try JSONSerialization.data(withJSONObject: dictionary)
    }
    
}
