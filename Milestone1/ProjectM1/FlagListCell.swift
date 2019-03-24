//
//  FlagListCell.swift
//  Project4
//
//  Created by Shantanu Dutta on 18/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class FlagListCell: UITableViewCell {
    
    var imageName: String! {
        didSet {
            setupViews()
        }
    }
    @IBOutlet weak var flagContainer: UIView!
    @IBOutlet weak var flagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupViews() {
        flagImage.image = UIImage(named: imageName)
        // Add shadow
        flagImage.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        flagImage.layer.shadowOpacity = 0.8
        flagImage.layer.shadowOffset = CGSize(width: 2, height: 2)
        flagImage.layer.shadowRadius = 10
        flagImage.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        flagImage.layer.borderWidth = 1
//        flagImage.layer.masksToBounds = true
        flagImage.layer.shadowPath = UIBezierPath(rect: flagImage.bounds).cgPath
    }
}
