//
//  DetailsPhotoController.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 02.05.2021.
//

import UIKit

class DetailsPhotoController: UIViewController {

    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var linksURL: URLLinks!
//    var photoURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
//        oneImage()
//        twoImage()
//        threeImage()
        print(linksURL ?? "")
    }
    
    private func oneImage() {
        guard let url = URL(string: linksURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            guard let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.detailsImageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
