//
//  NotesModel.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import Foundation

struct NotesResponse: Decodable {
    let invites: Invites?
    let likes: Likes?
}

struct Invites: Decodable {
    let profiles: [Profile]
}

struct Likes: Decodable {
    let profiles: [Like]
    let can_see_profile: Bool
    let likes_received_count: Int
}

struct Profile: Decodable {
    let generalInformation: GeneralInformation
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case generalInformation = "general_information"
        case photos
    }
    
    var name: String {
        generalInformation.firstName
    }
    
    var avatar: String? {
        photos.first(where: { $0.selected == true })?.photo
    }
}

struct GeneralInformation: Decodable {
    let firstName: String
    let refId: String?
    let age: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case refId = "ref_id"
        case age
    }
}


struct Photo: Decodable {
    let photo: String
    let selected: Bool?
}

struct Like: Decodable {
    let first_name: String
    let avatar: String
}
