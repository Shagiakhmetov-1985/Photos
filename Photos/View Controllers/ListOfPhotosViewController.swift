//
//  ListOfPhotosViewController.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 05.05.2021.
//

import UIKit
import Alamofire

class ListOfPhotosViewController: UITableViewController {
    
    var wallpapers: [Wallpaper] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 500
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wallpapers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WallpapersCell
        let wallpaper = wallpapers[indexPath.row]
        cell.configure(with: wallpaper)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListOfPhotosViewController {
    func fetchWallpapers() {
        guard let url = URL(string: URLLinks.imageURLSix.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.wallpapers = try decoder.decode([Wallpaper].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func alamofireGet() {
        AF.request(URLLinks.imageURLSix.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self.wallpapers = Wallpaper.getWallpapers(from: value)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func alamofirePost() {
        let wallpapers = WallpaperAlamofirePost(
            id: "164",
            author: "Linh Nguyen",
            width: 1200,
            height: 800,
            url: "https://unsplash.com/photos/agkblvPff5U",
            downloadUrl: URLLinks.imageURLEight.rawValue
        )
        
        AF.request(URLLinks.imageURLSeven.rawValue, method: .post, parameters: wallpapers)
            .validate()
            .responseDecodable(of: WallpaperAlamofirePost.self) { dataResponse in
                switch dataResponse.result {
                case .success(let wallpapersAlamofirePost):
                    let wallpaper = Wallpaper(
                        id: wallpapersAlamofirePost.id,
                        author: wallpapersAlamofirePost.author,
                        width: wallpapersAlamofirePost.height,
                        height: wallpapersAlamofirePost.width,
                        url: wallpapersAlamofirePost.url,
                        downloadUrl: wallpapersAlamofirePost.downloadUrl
                    )
                    self.wallpapers.append(wallpaper)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
