//
//  MyCollectionViewCell.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/29/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit
class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            myImageView.layer.borderWidth = isSelected ? 10 : 0
        }
    }
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.layer.borderColor = huddleColors.huddlePurple.pickThisColor.cgColor
        isSelected = false
    }
    
    
}
