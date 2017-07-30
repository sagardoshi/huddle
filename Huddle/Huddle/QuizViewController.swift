//
//  QuizViewController.swift
//  Huddle
//
//  Created by Sagar Doshi on 7/17/17.
//  Copyright © 2017 Beroshi Studios. All rights reserved.
//

import UIKit

var currentQuiz = 1

class QuizViewController: UIViewController {

    var correctAnswerChosen = false
    var overlayVisible = false
    
    var quiz1Completed = false
    var quiz2Completed = false
    var quiz3Completed = false
    
    
    enum quiz1Responses: String {
        case first =
            "KEEP EXPERIMENTING!\n\nSaying anything to offer support is always better than saying nothing. This is a closed-ended question, which can often lead to a defensive answer, like \"I'm fine,\" which might shut down an avenue for help.\n\nWhen beginning a conversation to offer support, try asking a more open-ended question or try making a more direct offer to help that does not center on the person's well-being."
        
        case second =
            "NICELY DONE!\n\nThis is a great way to lend a hand.\n\nIn a situation where someone might be suffering from a more serious condition, asking an open-ended question or being direct about your concern and offer to help is always a useful strategy.\n\nYou're off to a great start!"
        
        case third =
            "TRY AGAIN!\n\nBe careful when a friend is in a specific circumstance of need, like this. Immediate advice without first understanding the need can often shut down the conversation. Sometimes, it can make the other person feel judged, as if he is incapable of taking care of the situation himself.\n\nThe most effective way to approach this situation is to express concern first."
        
        case fourth =
            "TRY AGAIN!\n\nSaying anything to offer support is always better than saying nothing.\n\nIt's possible that you are the only one around who noticed something wrong.\n\nWhen a friend might be dealing with a more serious situation, there will certainly be people who can offer professional support. However, you can help connect your friend to resources that might at first seem daunting."
        
//        case fifth =
//            "NICE!\n\nSaying anything to offer support is always better than saying nothing.\n\nWhen beginning a conversation to offer support, asking open-ended questions or more direct offers to help are often effective strategies."
    }
    
    enum quiz2Responses: String {
        case firstsecond =
            "TRY AGAIN!\n\nBe careful when a friend is in a specific circumstance of need, like this. Immediate advice without first understanding the need can often shut down the conversation. Sometimes, it can make the other person feel judged, as if she is incapable of taking care of the situation herself.\n\nThe most effective way to approach this situation is to articulate why you\'re concerned first."
        
        case third =
            "KEEP EXPERIMENTING!\n\nBeing a supportive friend means taking care of yourself first. However, if you are able, it is always better to say anything to to not respond at all.\n\nAn effective way to show your support is by expressing your concern and articulating why you are concerned."
        
        case fourth =
            "NICE WORK!\n\nThe most effective way to start a supportive conversation is by expressing concern and clearly articulating why you're concerned.\n\nIn this case, you do this by saying that you don\'t think they look well and then expressing concern in a way that shows sympathy without talking down to them."
        
//        case fifth =
//            "NICE!\n\nSaying anything to offer support is always better than saying nothing.\n\nWhen beginning a conversation to offer support, ask open-ended questions or more direct offers to help in a way that expresses your concern AND articulates what you\'ve noticed to explain why you\'re concerned."
        
    }
    
    // Header Image and Description Outlets
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerDescription: UILabel!
    
    // Overlay Outlets
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var overlayViewText: UILabel!
    @IBOutlet weak var overlayViewCancelButtonStackView: UIStackView!
    @IBOutlet weak var overlayViewCancelButton: UIButton!
    @IBOutlet weak var overlayViewProceedButtonStackView: UIStackView!
    @IBOutlet weak var overlayViewProceedButton: UIButton!
    
    @IBOutlet weak var overlayTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayBottomConstraint: NSLayoutConstraint!
    
    
    // Button Outlets
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet var quizButtons: [UIButton]!
    
    
    // Quiz Header Icons
    
    let q1HeaderImage = UIImage(named: "backpack_icon")!
    let q2HeaderImage = UIImage(named: "tissue_icon")!
    
    // Quiz Header Descriptions
    
    let q1HeaderDescription = "How might you start (or not start) a conversation by *expressing concern* in this scenario?"
    let q2HeaderDescription = "How might you start (or not start) a conversation to *articulate why you're concerned* in this scenario?"
    
    // Quiz Button Descriptions
    
    let q1ButtonDescriptions: [String] = ["Hi! Are you okay?",
                                          "Hey! I can help you.",
                                          "You should try a different bag.",
                                          "*Someone will help them*"]
//                                          "Other________"]
    
    let q2ButtonDescriptions: [String] = ["Do you want a cough drop?",
                                          "You should go to a doctor.",
                                          "*Go to a different room so you can focus.*",
                                          "Hey. You don't look well. Can I help in any way?"]
//                                          "Other________"]
    

    func labelButtons (buttonCollection: [UIButton], buttonDescriptions: [String]) {
        var i = 0
        for eachButton in buttonCollection {
            
            // Dynamically add title, given quiz number
            eachButton.setTitle(buttonDescriptions[i], for: UIControlState.normal)
            eachButton.titleLabel?.adjustsFontSizeToFitWidth = true
            
            // Tag each button in order (using standard numbering to match with string variables later)
            eachButton.tag = i + 1
            
            i += 1
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch currentQuiz {
        case 1:
            headerImage.image = q1HeaderImage
            headerDescription.text = q1HeaderDescription
            labelButtons(buttonCollection: quizButtons, buttonDescriptions: q1ButtonDescriptions)
        case 2:
            headerImage.image = q2HeaderImage
            headerDescription.text = q2HeaderDescription
            labelButtons(buttonCollection: quizButtons, buttonDescriptions: q2ButtonDescriptions)
        default:
            headerDescription.text = q1HeaderDescription
            labelButtons(buttonCollection: quizButtons, buttonDescriptions: q1ButtonDescriptions)
        }
        headerDescription.adjustsFontSizeToFitWidth = true
    }
    

    @IBAction func answerGiven(_ whichButton: UIButton) {
        
        // Initialize the necessary variables
        
        var selectedText: String = ""
        var selectedBackground: UIColor?
        
        let failBackground: UIColor = huddleColors.huddlePink.pickThisColor
        let succeedBackground: UIColor = huddleColors.huddleGreen.pickThisColor
//        let otherBackground: UIColor = huddleColors.huddleYellow.pickThisColor
        
        // Be ready for wrong answers first
        overlayViewProceedButtonStackView.isHidden = true
        overlayViewCancelButtonStackView.isHidden = false
        
        // Slot the appropriate content to the correct variable
        
        selectedBackground = failBackground;
        
        
        switch currentQuiz {
        
        // Answers for Quiz 1
        case 1:
            switch whichButton.tag {
            case 1:
                selectedText = quiz1Responses.first.rawValue
            
            // The winning answer
            case 2:
                selectedText = quiz1Responses.second.rawValue
                selectedBackground = succeedBackground;
                correctAnswerChosen = true
                
                overlayViewCancelButtonStackView.isHidden = true
                overlayViewProceedButtonStackView.isHidden = false

            case 3:
                selectedText = quiz1Responses.third.rawValue
            case 4:
                selectedText = quiz1Responses.fourth.rawValue
//            case 5:
//                selectedText = quiz1Responses.fifth.rawValue
//                selectedBackground = otherBackground;
            default:
                selectedText = ""
            }
        
        // Answers for Quiz 2
        case 2:
            switch whichButton.tag {
            case 1, 2:
                selectedText = quiz2Responses.firstsecond.rawValue
            case 3:
                selectedText = quiz2Responses.third.rawValue
            
            // The winning answer
            case 4:
                selectedText = quiz2Responses.fourth.rawValue
                selectedBackground = succeedBackground;
                correctAnswerChosen = true
                
                overlayViewCancelButtonStackView.isHidden = true
                overlayViewProceedButtonStackView.isHidden = false
//            case 5:
//                selectedText = quiz1Responses.fifth.rawValue
//                selectedBackground = otherBackground;
            default:
                selectedText = ""
            }
        default:
            break;
        }
        
        // Show and initialize the selected content
        overlayViewText.text = selectedText
        overlayViewText.adjustsFontSizeToFitWidth = true
        overlayView.backgroundColor = selectedBackground
        
       
        // Animate upward
        if (!overlayVisible) {
            overlayTopConstraint.constant = 100
            overlayBottomConstraint.constant = 20
        }
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        overlayVisible = !overlayVisible

    }
    
    @IBAction func removeOverlay(_ sender: Any) {
        if (overlayVisible) {
            overlayTopConstraint.constant = 650
            overlayBottomConstraint.constant = -550
        }
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        overlayVisible = !overlayVisible
        
    }
    
    @IBAction func augmentScore(_ sender: Any) {
        if correctAnswerChosen == true {
            switch currentQuiz {
            case 1:
                quiz1Completed = true
                performSegue(withIdentifier: "Quiz 1 Done", sender: self)
            case 2:
                score += 20 // Only get bump for finishing both parts of drill
                level += 1 // Drill 1 complete!
                quiz2Completed = true
                performSegue(withIdentifier: "Quiz 2 Done", sender: self)
            default:
                break;
            }
            currentQuiz += 1
        }

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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
