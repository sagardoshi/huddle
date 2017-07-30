//
//  ResourcesViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/19/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    
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
