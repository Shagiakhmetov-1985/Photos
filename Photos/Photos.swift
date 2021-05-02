//
//  Photos.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 02.05.2021.
//

struct Photos: Decodable {
    let imageUrl: String?
}

struct WebSiteDescription {
    let photos: [Photos]?
    let websiteDescription: String?
    let websiteName: String?
}
