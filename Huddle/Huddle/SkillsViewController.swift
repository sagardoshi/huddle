//
//  SkillsViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/18/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

var isFirstSkillsScreen = true

class SkillsViewController: UIViewController {
    
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var skill1: UILabel!
    @IBOutlet weak var skill2: UILabel!
    @IBOutlet weak var skill3: UILabel!
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var clearOverlay: UIButton!
    @IBOutlet weak var overlayTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayBottomConstraint: NSLayoutConstraint!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isFirstSkillsScreen {
            subtitle.text = "Drill 2: Convo Continues"
            skill1.text = "Respond and reflect."
            skill2.text = "Ask open-ended questions."
            skill3.text = "Pursue understanding."
        }
        
    }
    
    
    @IBAction func removeOverlay(_ sender: Any) {
        overlayTopConstraint.constant = 650
        overlayBottomConstraint.constant = -550
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
    }
    
    
    
    // All below is related to menu animation
    
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuTopConstraint: NSLayoutConstraint!
    
    var menuVisible = false
    
    
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
