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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

extension DetailsPhotoController {
    
    func oneImage() {
        guard let url = URL(string: URLLinks.imageURLOne.rawValue) else { return }
        
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
    
    func twoImage() {
        guard let url = URL(string: URLLinks.imageURLTwo.rawValue) else { return }
        
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
    
    func threeImage() {
        guard let url = URL(string: URLLinks.imageURLThree.rawValue) else { return }
        
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
