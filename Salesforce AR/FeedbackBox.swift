//
//  FeedbackBox.swift
//  Salesforce AR
//
//  Created by Kartik Agrawal on 8/4/17.
//  Copyright © 2017 Kartik Agrawal. All rights reserved.
//

import Foundation
import ARKit

class FeedbackBox : UIViewController{
    
    func welcome() ->String{
        return " Welcome to Salesforce AR!"
    }
    func mascotSelect() ->String {
        return "Select your favorite mascot"
    }
    func unsupportedMascot() ->String{
        return "For the scope of the project, please select Codey"
    }
}
