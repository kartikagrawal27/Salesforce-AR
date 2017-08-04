//
//  ViewController.swift
//  Salesforce AR
//
//  Created by Kartik Agrawal on 7/31/17.
//  Copyright © 2017 Kartik Agrawal. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController{
    
    var buttons = [UIButton]()
    @IBOutlet var astro: UIButton!
    @IBOutlet var cloudy: UIButton!
    @IBOutlet var codey: UIButton!
    @IBOutlet var einstein: UIButton!
    @IBOutlet var augmentView: ARSCNView!
    @IBOutlet var ar: UILabel!
    @IBOutlet var salesforceImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttons.append(astro)
        buttons.append(cloudy)
        buttons.append(codey)
        buttons.append(einstein)
        self.salesforceImg.alpha = 0.0
        initialize()
        
        let scene = SCNScene()
        augmentView.scene = scene
        
        //        addObject()
    }
    
    
    @IBAction func initialize()
    {
        self.augmentView.alpha = 0.0
        
        self.ar.alpha = 0.0
        for button in self.buttons{
            button.alpha = 0.0
            button.layer.backgroundColor = UIColor.clear.cgColor
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.layer.cornerRadius = 20.0
        }
        
        
        // fade in
        UIView.animate(withDuration: 2, animations: {
            self.salesforceImg.alpha = 1.0
        }) { (finished) in
            // fade in
            UIView.animate(withDuration: 2.5, animations: {
                self.ar.alpha = 1.0
            }) { (finished) in
                UIView.animate(withDuration: 1.5, animations: {
                    self.ar.alpha = 0.0
                    self.salesforceImg.alpha = 0.0
                }) {(finished) in
                    let configuration = ARWorldTrackingSessionConfiguration()
                    self.augmentView.session.run(configuration)
                    configuration.planeDetection = .horizontal
                    UIView.animate(withDuration: 3.0, animations: {
                        self.augmentView.alpha = 1.0
                        for  button in self.buttons{
                            button.alpha = 1.0
                        }
                    })
                }
            }
        }
    }
    
    func addObject(){
        let bear = Mascots()
        bear.loadCody()
        
        let xPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        let yPos = randomPosition(lowerBound: -1.5, upperBound: 1.5)
        
        bear.position = SCNVector3(xPos, yPos, -1)
        bear.scale = SCNVector3(0.02, 0.02, 0.02)
        
        augmentView.scene.rootNode.addChildNode(bear)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    func randomPosition(lowerBound lower:Float, upperBound upper:Float) -> Float{
        return Float(arc4random())/Float(UInt32.max) * (lower-upper) + upper
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        augmentView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


