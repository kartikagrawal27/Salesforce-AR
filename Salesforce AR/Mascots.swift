//
//  Mascot.swift
//  Salesforce AR
//
//  Created by Kartik Agrawal on 8/1/17.
//  Copyright © 2017 Kartik Agrawal. All rights reserved.
//

import ARKit

class Mascots: SCNNode {
    
    func loadCody(){
        guard let myBear = SCNScene(named : "art.scnassets/Codey.dae") else {return}
        let wrapperNode = SCNNode()
        
        for child in myBear.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
        
        self.addChildNode(wrapperNode)

    }

}
