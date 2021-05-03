//
//  MainViewController.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 02.05.2021.
//

import UIKit

enum URLExamples: String {
    case imageURLOne = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case imageURLTwo = "https://images.wallpaperscraft.ru/image/doroga_povorot_derevia_205322_2160x3840.jpg"
    case imageURLThree = "https://images.wallpaperscraft.ru/image/gory_holmy_derevia_205309_2160x3840.jpg"
    case imageURLFour = "https://images.wallpaperscraft.ru/image/palma_listia_more_205264_2160x3840.jpg"
    case imageURLFive = "https://images.wallpaperscraft.ru/image/zakat_solntse_voda_205212_2160x3840.jpg"
}

enum PhotoOnMain: String, CaseIterable {
    case photoOne = "iPhone-SE-11"
    case photoTwo = "doroga_povorot_derevia_205322_2160x3840"
    case photoThree = "gory_holmy_derevia_205309_2160x3840"
    case photoFour = "palma_listia_more_205264_2160x3840"
    case photoFive = "zakat_solntse_voda_205212_2160x3840"
}

class MainViewController: UICollectionViewController {
    
    let photoOnMain = PhotoOnMain.allCases
    
    private let itemPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        title = "Wallpapers"
    }
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoOnMain = photoOnMain[indexPath.item]

        switch photoOnMain {
        case .photoOne: performSegue(withIdentifier: "pickPhotoSegue", sender: nil)
        case .photoTwo: oneButtonPressed()
        case .photoThree: oneButtonPressed()
        case .photoFour: oneButtonPressed()
        case .photoFive: oneButtonPressed()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoOnMain.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
    
        let imageName = photoOnMain[indexPath.item]
        let image = UIImage(named: imageName.rawValue)
        
        cell.imageView.image = image
    
        return cell
    }
    // MARK: - Private methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug area",
                preferredStyle: .alert
            )
                
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Work with size of photos
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = sectionInserts.left * (itemPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    private func oneButtonPressed() {
        guard let url = URL(string: URLExamples.imageURLTwo.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let photo = try JSONDecoder().decode(Photos.self, from: data)
                self.successAlert()
                print(photo)
            } catch let error {
                self.failedAlert()
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
