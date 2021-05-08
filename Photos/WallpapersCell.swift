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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func configure(with wallpapers: Wallpaper) {
        titleLabel.text = wallpapers.author
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        
        DispatchQueue.global().async {
            guard let stringURL = wallpapers.downloadUrl else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.wallpaperImage.image = UIImage(data: imageData)
                self.indicator.stopAnimating()
            }
        }
    }

}
