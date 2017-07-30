//: Playground - noun: a place where people can play

import UIKit

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

huddleColors.huddleWhite.pickThisColor

enum quiz1Responses: String {
    case firstFail =
    "KEEP EXPERIMENTING!\n\nSaying anything to offer support is always better than saying nothing.\n\nDepending on the situation, starting a conversation with \"Are you okay?\" can often lead to a defensive answer, like \"I'm fine,\" which might shut down an avenue for help.\n\nWhen beginning a conversation to offer support, try asking a more open-ende question or a more direct offer to help that does not center on the person's need to be okay."
    
    case secondSucceed =
    "NICELY DONE!\n\nThis is a great way to lend a hand.\n\nIn a situation where someone might be suffering from a more serious condition, asking an open-ended question or being direct about your concern and desire to help is always a useful strategy.\n\nYou're off to a great start!"
    
    case thirdFail =
    "TRY AGAIN!\n\nSaying anything to offer support is always better than saying nothing.\n\nEspecially when a friend is in a specific situation where they're in need, immediately suggesting alternative advice without pursuing understanding first can often shut down the conversation or make them feel they cannot be trusted or that they lack control.\n\nThe most effective way to approach this situation is to express concern first."
    
    case fourthFail =
    "TRY AGAIN!\n\nSaying anything to offer support is always better than saying nothing.\n\nIt's possible that you are the only one who was in a position to notice something was wrong.\n\nWhen a friend might be dealing with a more serious situation, there will certainly be people who can offer professional support. However, you can be a medium between your friend and these resources that they may not know of or have the ability to access."
    
    case fifthOther =
    "NICE!\n\nSaying anything to offer support is always better than saying nothing.\n\nWhen beginning a conversation to offer support, asking open-ended questions or more direct offers to help are often effective strategies."
}

quiz1Responses.firstFail.rawValue

