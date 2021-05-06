//
//  ListOfPhotosViewController.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 05.05.2021.
//

import UIKit

class ListOfPhotosViewController: UITableViewController {

    var wallpapers: [Wallpapers] = []
    
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
                self.wallpapers = try decoder.decode([Wallpapers].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
}
