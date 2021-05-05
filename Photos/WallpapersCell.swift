//
//  WallpapersCell.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 05.05.2021.
//

import UIKit

class WallpapersCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wallpaperImage: UIImageView!
    
    func configure(with wallpapers: Wallpapers) {
        titleLabel.text = wallpapers.name
//        print(wallpapers.name ?? "no")
        DispatchQueue.global().async {
            guard let stringURL = wallpapers.imageUrl else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.wallpaperImage.image = UIImage(data: imageData)
            }
        }
    }

}
