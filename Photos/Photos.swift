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
    
    init(wallpaperData: [String: Any]) {
        id = wallpaperData["id"] as? String
        author = wallpaperData["author"] as? String
        width = wallpaperData["width"] as? Int
        height = wallpaperData["heigth"] as? Int
        url = wallpaperData["url"] as? String
        downloadUrl = wallpaperData["download_url"] as? String
    }
    
    static func getWallpapers(from value: Any) -> [Wallpaper] {
        guard let wallpapersData = value as? [[String: Any]] else { return [] }
        return wallpapersData.compactMap { Wallpaper(wallpaperData: $0) }
    }
}
