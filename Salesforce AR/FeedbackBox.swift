//
//  FeedbackBox.swift
//  Salesforce AR
//
//  Created by Kartik Agrawal on 8/4/17.
//  Copyright © 2017 Kartik Agrawal. All rights reserved.
//

import Foundation
import UIKit

class FeedbackBox : UIViewController{
    func welcome() ->String{
        return " Welcome to Salesforce AR!"
    }
    func mascotSelect() ->String {
        return "Meet your favorite Salesforce Mascot!"
    }
    
    func unsupportedMascot() ->String{
        return "Uh-oh seems like everyone has gone hiking, except Codey!"
    }
    
    func UGMascotPresent() ->String{
        return "Codey is here! \nLook around!"
    }
    
    func UGdirections() ->String{
        return "Point to a horizontal surface and tap on their name"
    }
    
    func funcWhatsNext() ->String {
        return "Coming soon!"
    }
    
    func noSurface() ->String{
        return "Surface not detected,\n please try again"
    }
}
