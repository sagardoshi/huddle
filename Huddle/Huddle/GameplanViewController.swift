//
//  GameplanViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/17/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

class GameplanViewController: UIViewController {

    // Menu-related variables
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTopConstraint: NSLayoutConstraint!
    var menuVisible = false
    
    // Button-related variables
    
    @IBOutlet var gameStageStackViews: [UIStackView]!
    
    @IBOutlet var gameStageLabels: [UIButton]!
    @IBOutlet var gameStageIcons: [UIImageView]!
    
    let highlightedIcons: [UIImage] = [UIImage(named: "basketball_white_icon")!, UIImage(named: "hoop_white_icon")!]
    
    
    @IBAction func prepareDrill2Skills(_ sender: Any) {
        isFirstSkillsScreen = false
    }
    
    func disableAllButtons (listOfButtons: [UIButton]) {
        for eachButton in listOfButtons {
            eachButton.isEnabled = false
        }
    }
    
    func highlightCurrentStage (currentLevel: Int) {
        for (index, button) in gameStageLabels.enumerated() {
            if index <= currentLevel {
                button.isEnabled = true
            }
            if index == currentLevel {
                gameStageIcons[index].image = highlightedIcons[currentLevel % 2]
                
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
                button.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 16)
                
                // Highlighted entire row
                button.layer.cornerRadius = 10
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.white.cgColor
                button.backgroundColor = button.backgroundColor?.withAlphaComponent(1)
            }
            if index > currentLevel {
                button.setTitleColor(UIColor.gray, for: .normal)
            }
        }
        
    }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        disableAllButtons(listOfButtons: gameStageLabels)
        highlightCurrentStage(currentLevel: level)
    }
    
    
    
    
    // Animation of Menu
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


    
}
