//
//  Photos.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 02.05.2021.
//

struct Photos: Decodable {
    let id: Int?
    let title: String?
    let body: String?
}

//struct WebSiteDescription {
//    let photos: [Photos]?
//    let websiteDescription: String?
//    let websiteName: String?
//}

struct Wallpapers: Decodable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct Wallpaper: Decodable {
    let image: String?
    let id: Int?
    let title: String?
}
