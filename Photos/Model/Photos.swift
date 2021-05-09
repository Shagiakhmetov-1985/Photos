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
    
    init(id: String, author: String, width: Int, height: Int, url: String, downloadUrl: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.downloadUrl = downloadUrl
    }
    
    static func getWallpapers(from value: Any) -> [Wallpaper] {
        guard let wallpapersData = value as? [[String: Any]] else { return [] }
        return wallpapersData.compactMap { Wallpaper(wallpaperData: $0) }
    }
}

struct WallpaperAlamofirePost: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String
}
