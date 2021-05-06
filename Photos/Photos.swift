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

struct Wallpaper: Decodable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let downloadUrl: String?
}
