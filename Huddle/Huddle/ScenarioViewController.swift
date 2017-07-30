//
//  ScenarioViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/18/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

class ScenarioViewController: UIViewController {

    
    @IBOutlet weak var scenarioTitle: UILabel!
    @IBOutlet weak var scenarioDescription: UILabel!
    @IBOutlet weak var scenarioButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set text
        switch currentQuiz {
        case 1:
            scenarioTitle.text = "Scenario 1"
            scenarioDescription.text = "It's the first week of class. You're leaving your dorm. You see someone from your hall rush by you, and his backpack gets caught on the door and rips.\n\nAll of his papers and books have fallen onto the floor and he looks flustered. People are walking around him to avoid the mess."
            scenarioButton.setTitle("Express Concern", for: UIControlState.normal)
        case 2:
            scenarioTitle.text = "Scenario 2"
            scenarioDescription.text = "You're in the lounge of your dorm. A person that you see around the halls is doing homework on a nearby couch.\n\nHer nose is red, she looks tired, and she keeps getting into coughing fits."
            scenarioButton.setTitle("Articulate Signs", for: UIControlState.normal)
        default:
            break;
        }
        
    }
    
    // All below is related to menu animations
    
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

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
