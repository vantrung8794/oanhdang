//
//  swift
//  Tecomen
//
//  Created by TrungNV on 3/4/20.
//  Copyright © 2020 ttc-solutions. All rights reserved.
//

import UIKit

struct Constants {

}

struct URLs {
    static let devBaseURL           = "https://immense-hamlet-71289.herokuapp.com"
}

struct Colors {
    static let blackColor           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let black333             = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let growTextColor        = #colorLiteral(red: 0.4196078431, green: 0.4196078431, blue: 0.4196078431, alpha: 1)
    static let redTextColor         = #colorLiteral(red: 1, green: 0.3215686275, blue: 0.1725490196, alpha: 1)
    static let primaryColor         = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    static let whiteColor           = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let growBG               = #colorLiteral(red: 0.8980392157, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
    static let blueLinkColor        = #colorLiteral(red: 0.1450980392, green: 0.5450980392, blue: 0.8705882353, alpha: 1)
    static let blueTextColor        = #colorLiteral(red: 0.09019607843, green: 0.5137254902, blue: 0.862745098, alpha: 1)

    static let leftColor            = #colorLiteral(red: 0, green: 0.6392156863, blue: 0.9294117647, alpha: 1)
    static let rightColor           = #colorLiteral(red: 0, green: 0.3843137255, blue: 0.831372549, alpha: 1)

    static let stateOkColor         = #colorLiteral(red: 0, green: 0.8666666667, blue: 0.1647058824, alpha: 1)
    static let stateNotOkColor      = #colorLiteral(red: 1, green: 0.3215686275, blue: 0.1725490196, alpha: 1)
    static let stateMediumColor     = #colorLiteral(red: 1, green: 0.7803921569, blue: 0.003921568627, alpha: 1)

    static let shadowColor          = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)

}

struct YapCollections {
    static let userInfo             = "userInfo"
}

struct NotificationKeys {
    static let received             = "com.firebase.notifi.received"
    static let loading              = "com.ui.loading.hide"
    static let showMsg              = "com.ui.msg.show"
}

struct KeyChainKeys {
}
