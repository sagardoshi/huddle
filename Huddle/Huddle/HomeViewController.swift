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
let profilePhotosPath: URL! = getDocumentsDirectory().appendingPathComponent("ProfilePhotos")


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var verticalLabel: UIButton!
    @IBOutlet weak var strengthLevelLabel: UILabel!
    
    
    @IBOutlet weak var huddleGroupBackground: UIImageView!
    @IBOutlet weak var buttonToPhotoLibrary: UIButton!
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTopConstraint: NSLayoutConstraint!
    var menuVisible = false
    
    
    func tintHuddleGroupBackground(currentScore: Int) {
        var colorChoice = UIColor()
        
        switch currentScore {
        case 0..<20:
            colorChoice = UIColor.clear
        case 20..<70:
            colorChoice = huddleColors.huddlePurple.pickThisColor
        case 70..<120:
            colorChoice = huddleColors.huddlePink.pickThisColor
        case 120..<Int.max:
            colorChoice = huddleColors.huddleYellow.pickThisColor
        default:
            colorChoice = UIColor.clear
        }
        
        huddleGroupBackground.tintColor = colorChoice

        // Match label color to Huddle group background color
        
        if currentScore < 0 {
            colorChoice = huddleColors.huddleWhite.pickThisColor
        }
        
        strengthLevelLabel.textColor = colorChoice
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if score >= 50 {
            buttonToPhotoLibrary.isHidden = false
        }
        
        verticalLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        strengthLevelLabel.text = "Strength Level: \(score)"
        
        tintHuddleGroupBackground(currentScore: score)
        
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
        
        
    }
    
}

