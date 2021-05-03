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
    
//    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
//        detailsImageView.image = image
    }
    
    private func fetchImage() {
        guard let url = URL(string: URLExamples.imageURLOne.rawValue) else { return }

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
