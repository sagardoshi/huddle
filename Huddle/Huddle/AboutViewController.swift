//
//  AboutViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/18/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var currentAboutPage = 0
    var totalPages = 0
    
    @IBOutlet weak var basketballIcon: UIImageView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var progressionButton: UIButton!
    
    var iconContent: [UIImage] = [UIImage(named: "bball1_icon")!, UIImage(named: "bball2_icon")!]
    
    var pageContent: [String] =
        ["A small group of your dormmates who you will work with to form a support system as you start your college experience.",
         "This is about getting better at talking about mental health problems to support your friends.\n\nIt's also about getting to know each other, so that you people to lean on throughout your freshman year."]
    
    var oldPageContent: [String] =
            ["A small group of your dormmates who you will work with to form a support system as you start your college experience.",
             "Imagine you're playing a game of basketball. There will be low points and high points in how you're playing and how your team's playing. You have to hydrate and take care of yourself. You have to cheer each other on to keep morale up. Sometimes, you form a huddle where you circle up with your whole team during a time-out.\n\n**Your huddle reminds you that you are a team.** That this is a challenging experience. That you can get through this if you work together to support each other.",
             "We're bringing this idea to the college playing field as you transition during your freshman year because we are all stronger, more successful, and more mentally fit students if we **build a circle of support around us.\n\nCollege students will first turn to a peer** before they turn to an adult if they're dealing with a mental health problem. More often than not, that friend does not know how to react or respond to support them. We're trying to change that.",
             "**With Huddle:**\n1. You will become **more prepared** to have supportive conversations with friends in need – especially in situations of mental illness.\n\n2. You will get close to a small group of friends in your dorm whom **you can lean on** as your own freshman \"game\" has its lows and highs.\n\n3. You can **access resources, emergency help, and additional opportunities** to practice becoming a stronger mental health ally, college student, and friend to your peers.",
             "Your goal is to work through your **Gameplan** to make your Huddle stronger. Each of you in your Huddle **contribute to making it stronger** every time you complete an item in your Gameplan.\n\n You will practice **\"Drills\"** to learn supportive conversational strategies and play out those strategies in **\"Scrimmages\"** where you apply the skills you've learned with a friend from your Huddle in the real world."]
    
    @IBAction func progressPage(_ sender: Any) {
        if currentAboutPage == totalPages - 1 {
            performSegue(withIdentifier: "About to Huddle", sender: self)
            return
        } else if currentAboutPage == 0 {
            titleStackView.isHidden = true
        }
        
        currentAboutPage += 1
        updatePage()
    }
    
    func updatePage() {
        contentLabel.text = pageContent[currentAboutPage]
        contentLabel.adjustsFontSizeToFitWidth = true
        basketballIcon.image = iconContent[currentAboutPage]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalPages = pageContent.count
        updatePage()
    }
    

}
