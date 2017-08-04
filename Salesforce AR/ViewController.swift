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
    @IBOutlet var whatsNext: UIButton!
    @IBOutlet var miniSalesforce: UIImageView!
    @IBOutlet var shade: UILabel!
    var feedBox: FeedbackBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeExperience()
    }
    
    func initializeExperience()
    {
        initializeButtons()
        initializeAlphas()
        initializeAnimations()
    }
    
    fileprivate func initializeButtons() {
        self.buttons.append(astro)
        self.buttons.append(cloudy)
        self.buttons.append(codey)
        self.buttons.append(einstein)
        self.buttons.append(whatsNext)
    }
    
    fileprivate func initializeAlphas() {
        self.miniSalesforce.alpha = 0.0
        self.shade.backgroundColor = UIColor.black
        self.shade.alpha = 0.0
        self.augmentView.alpha = 0.0
        self.salesforceImg.alpha = 0.0
        self.ar.alpha = 0.0
        for button in self.buttons{
            button.alpha = 0.0
            button.layer.backgroundColor = UIColor.clear.cgColor
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.layer.cornerRadius = 20.0
        }
        self.buttons[4].layer.backgroundColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.buttons[4].layer.cornerRadius = 20
    }
    
    fileprivate func initializeAnimations() {
        UIView.animate(withDuration: 2, animations: {
            self.salesforceImg.alpha = 1.0
        }) { (finished) in
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
                    UIView.animate(withDuration: 0.5, animations: {
                        self.shade.alpha = 1.0
                    }) {(finished) in
                        UIView.animate(withDuration: 0.4, animations: {
                            self.buttons[0].alpha = 1.0
                        }) {(finished) in
                            UIView.animate(withDuration: 0.4, animations: {
                                self.buttons[1].alpha = 1.0
                            }) {(finished) in
                                UIView.animate(withDuration: 0.4, animations: {
                                    self.buttons[2].alpha = 1.0
                                }) {(finished) in
                                    UIView.animate(withDuration: 0.4, animations: {
                                        self.buttons[3].alpha = 1.0
                                    }) {(finished) in
                                        UIView.animate(withDuration: 1, animations: {
                                            self.augmentView.alpha = 1.0
                                            self.shade.alpha = 0.0
                                            self.whatsNext.alpha = 1.0
                                            self.miniSalesforce.alpha = 1.0
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        feedBox = FeedbackBox()
    }
    
    @IBAction func summonCodey(_ sender: Any) {
        addObject()
    }
    @IBAction func summonEinstein(_ sender: Any) {
        //TODO Configure addObject() once model available
    }
    @IBAction func summonAstro(_ sender: Any) {
        //TODO Configure addObject() once model available
    }
    
    @IBAction func summonCloudy(_ sender: Any) {
        //TODO Configure addObject() once model available
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
    
    override var prefersStatusBarHidden : Bool {
        return true
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
    
    func randomPosition(lowerBound lower:Float, upperBound upper:Float) -> Float{
        return Float(arc4random())/Float(UInt32.max) * (lower-upper) + upper
    }
    
    
}


