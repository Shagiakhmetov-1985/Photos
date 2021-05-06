//
//  MainViewController.swift
//  Photos
//
//  Created by Marat Shagiakhmetov on 02.05.2021.
//

import UIKit

enum URLLinks: String {
    case imageURLOne = "https://images.wallpaperscraft.ru/image/planety_galaktika_zvezdy_146448_2160x3840.jpg"
    case imageURLTwo = "https://images.wallpaperscraft.ru/image/doroga_povorot_derevia_205322_2160x3840.jpg"
    case imageURLThree = "https://images.wallpaperscraft.ru/image/gory_holmy_derevia_205309_2160x3840.jpg"
    case imageURLFour = "https://jsonplaceholder.typicode.com/posts/1"
    case imageURLFive = "https://jsonplaceholder.typicode.com/posts"
    case imageURLSix = "https://picsum.photos/v2/list"
}

enum PhotoOnMain: String, CaseIterable {
    case photoOne = "planety_galaktika_zvezdy_146448_2160x3840"
    case photoTwo = "doroga_povorot_derevia_205322_2160x3840"
    case photoThree = "gory_holmy_derevia_205309_2160x3840"
    case photoFour = "palma_listia_more_205264_2160x3840"
    case photoFive = "zakat_solntse_voda_205212_2160x3840"
    case photoSix = "soty_svechenie_obem_166024_2160x3840"
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
        //отображение первые три ячейки фото по url адресу
        case .photoOne: performSegue(withIdentifier: "pickPhotoSegueOne", sender: nil)
        case .photoTwo: performSegue(withIdentifier: "pickPhotoSegueTwo", sender: nil)
        case .photoThree: performSegue(withIdentifier: "pickPhotoSegueThree", sender: nil)
        //парсинг JSON
        case .photoFour: fourButtonPressed()
        case .photoFive: fiveButtonPressed()
        //парсинг JSON и отображение данных на экране
        case .photoSix: performSegue(withIdentifier: "pickPhotoSegueList", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "pickPhotoSegueList" {
            let photoVC = segue.destination as! DetailsPhotoController
            switch segue.identifier {
            case "pickPhotoSegueOne": photoVC.oneImage()
            case "pickPhotoSegueTwo": photoVC.twoImage()
            case "pickPhotoSegueThree": photoVC.threeImage()
            default: break
            }
            
        } else {
            let wallpaperVC = segue.destination as! ListOfPhotosViewController
            wallpaperVC.fetchWallpapers()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoOnMain.count
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

    private func fourButtonPressed() {
        guard let url = URL(string: URLLinks.imageURLFour.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let photo = try JSONDecoder().decode(Photos.self, from: data)
                self.successAlert()
                print(photo)
            } catch let error {
                self.failedAlert()
                print(error)
            }
            
        }.resume()
    }
    
    private func fiveButtonPressed() {
        guard let url = URL(string: URLLinks.imageURLFive.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let photo = try JSONDecoder().decode([Photos].self, from: data)
                self.successAlert()
                print(photo)
            } catch let error {
                self.failedAlert()
                print(error)
            }
            
        }.resume()
    }
}
