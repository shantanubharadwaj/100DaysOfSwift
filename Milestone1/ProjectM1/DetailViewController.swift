//
//  DetailViewController.swift
//  Project4
//
//  Created by Shantanu Dutta on 18/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    var selectedImage: String?
    var selectedCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            countryNameLabel.text = selectedCountry
            title = selectedCountry
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShareTapped))
            setupImageView()
        }
    }
    
    @objc func handleShareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage ?? "Image"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    func setupImageView() {
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
