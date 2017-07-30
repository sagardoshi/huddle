//
//  HomeViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/6/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit


// Mark: Setting official colors

enum huddleColors {
    case huddleGreen
    case huddlePurple
    case huddlePink
    case huddleYellow
    case huddleGray
    case huddleWhite
}

extension huddleColors {
    var pickThisColor: UIColor {
        get {
            switch self {
            case .huddleGreen: return UIColor(red:0.26, green:0.71, blue:0.27, alpha:1.0)
            case .huddlePurple: return UIColor(red:0.30, green:0.31, blue:0.63, alpha:1.0)
            case .huddlePink: return UIColor(red:0.76, green:0.25, blue:0.36, alpha:1.0)
            case .huddleYellow: return UIColor(red:0.76, green:0.62, blue:0.24, alpha:1.0)
            case .huddleGray: return UIColor(red:0.35, green:0.35, blue:0.36, alpha:1.0)
            case .huddleWhite: return UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
            }
        }
    }
}

// Mark: Initialize app-wide global variables

var score = 0
var level = 0

var titles: [String] = []
var images: [UIImage] = []

let imagePickerPath: URL! = getDocumentsDirectory().appendingPathComponent("ImagePicker")


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var verticalLabel: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var teamThumbnailCollectionView: UICollectionView!
    @IBOutlet weak var photoLibraryStackView: UIStackView!
    
    
    var teamArray: [String] = []
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTopConstraint: NSLayoutConstraint!
    var menuVisible = false
    
    // Get number of views in UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    // Populate cell views inside UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "huddleCell", for: indexPath) as! MyCollectionViewCell
//        cell.huddleHomeImageView.image = UIImage(named: teamArray[indexPath.row] + ".png")
        return cell
    }
    
    // Make it a nice, even size
    func sizeCollectionView() {
        let totalCollectionViewSize = UIScreen.main.bounds.width/3 - 5
        
        let thisLayout = UICollectionViewFlowLayout()
        
        // Obviated by the other spacing choices later
        //        thisLayout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        thisLayout.itemSize = CGSize(width: totalCollectionViewSize, height: totalCollectionViewSize)
        
        thisLayout.minimumInteritemSpacing = 5
        thisLayout.minimumLineSpacing = 5
        
        teamThumbnailCollectionView.collectionViewLayout = thisLayout
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if score >= 50 {
            photoLibraryStackView.isHidden = false
        }
        
//        sizeCollectionView()
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 5, height: 5)
        menuView.layer.shadowRadius = 5
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if menuVisible {
            toggleMenu(self)
        }
    }
    

    @IBAction func toggleMenu(_ sender: Any) {
        menuView.isHidden = false
        if (!menuVisible) {
            menuTopConstraint.constant = 0
        } else {
            menuTopConstraint.constant = -300
        }
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        
        menuVisible = !menuVisible
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        verticalLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        scoreLabel.text = String(score)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if score >= 50 {
            photoLibraryStackView.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

