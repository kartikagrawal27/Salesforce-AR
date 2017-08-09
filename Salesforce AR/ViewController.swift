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


class ViewController: UIViewController, ARSCNViewDelegate{
    
    var alreadyPresent :Bool!
    var hiddenPosition: CGPoint!
    var showPosition: CGPoint!
    var feedBox: FeedbackBox!
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
    @IBOutlet var feedback: UILabel!
    @IBOutlet var hangingCLoud: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSalesforceAR()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        augmentView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden : Bool {
        UIApplication.shared.isIdleTimerDisabled = true
        return true
    }
    
    func initializeSalesforceAR()
    {
        initializeState()
        initializeAlphas()
        initializeExperience()
    }
    
    fileprivate func initializeState() {
        augmentView.delegate = self
        self.alreadyPresent = false
        self.buttons.append(astro)
        self.buttons.append(cloudy)
        self.buttons.append(codey)
        self.buttons.append(einstein)
        self.buttons.append(whatsNext)
        for button in buttons{
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            visualEffectView.frame = button.bounds
            visualEffectView.layer.cornerRadius = 20.0
            visualEffectView.clipsToBounds = true
            visualEffectView.isUserInteractionEnabled = false
            button.addSubview(visualEffectView)
        }
        feedBox = FeedbackBox()
    }
    
    fileprivate func initializeAlphas() {
        self.hangingCLoud.alpha = 0.0
        self.feedback.alpha = 0.0
        self.miniSalesforce.alpha = 0.0
        self.shade.backgroundColor = UIColor.black
        self.shade.alpha = 0.0
        self.augmentView.alpha = 0.0
        self.salesforceImg.alpha = 0.0
        self.ar.alpha = 0.0
        for button in self.buttons{
            button.alpha = 0.0
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.layer.cornerRadius = 20.0
        }
        self.buttons[4].layer.borderColor = UIColor(red:16/255, green:154/255 ,blue:216/255, alpha:0.5).cgColor
        self.buttons[4].layer.borderWidth = 2.0
    }
    
    fileprivate func initializeExperience() {
        UIView.animate(withDuration: 1.5, animations: {
            self.salesforceImg.alpha = 1.0
        }) { (finished) in
            UIView.animate(withDuration: 1.5, animations: {
                self.ar.alpha = 1.0
            }) { (finished) in
                UIView.animate(withDuration: 2.0, animations: {
                    self.ar.alpha = 0.0
                    self.salesforceImg.alpha = 0.0
                }) {(finished) in
                    let configuration = ARWorldTrackingSessionConfiguration()
                    configuration.isLightEstimationEnabled = true
                    self.augmentView.session.run(configuration)
                    configuration.planeDetection = .horizontal
                    UIView.animate(withDuration: 2.0, animations: {
                        self.augmentView.alpha = 1.0
                        self.shade.alpha = 0.0
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
                                            self.whatsNext.alpha = 1.0
                                            self.miniSalesforce.alpha = 1.0
                                        })
                                        self.initializeFeedback()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func initializeFeedback(){
        feedback.text = feedBox.welcome()
        toggleFeedbackBox(initializing: true)
    }
    
    fileprivate func showFeedback() {
        self.hangingCLoud.center.y = 0.0
        self.hangingCLoud.alpha = 1.0
        self.feedback.center.y  = 28.0
        self.feedback.alpha = 1.0
    }
    
    fileprivate func hideFeedback() {
        self.hangingCLoud.center.y = -222
        self.hangingCLoud.alpha = 0.0
        self.feedback.center.y  = -222
        self.feedback.alpha = 0.0
    }
    
    fileprivate func toggleFeedbackBox(initializing:Bool){
        UIView.animate(withDuration:0.6 , animations: {
            self.showFeedback()
        }) {(finished) in
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when) {
                UIView.animate(withDuration: 0.6, animations:{
                    self.hideFeedback()
                }) {(finished) in
                    if(!initializing){
                        return
                    }
                    self.feedback.text = self.feedBox.mascotSelect()
                    UIView.animate(withDuration: 0.6, animations:{
                        self.showFeedback()
                    }) {(finished) in
                        let when = DispatchTime.now() + 3
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            UIView.animate(withDuration: 0.6, animations:{
                               self.hideFeedback()
                            }) {(finished) in
                                self.feedback.text = self.feedBox.UGdirections()
                                UIView.animate(withDuration: 0.6, animations:{
                                    self.showFeedback()
                                }) {(finished) in
                                    let when = DispatchTime.now() + 3
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        UIView.animate(withDuration: 0.6, animations:{
                                            self.hideFeedback()
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } 
    }
    
    @IBAction func ARPipeline(_ sender: Any) {
        feedback.text = feedBox.funcWhatsNext()
        toggleFeedbackBox(initializing: false)
    }
    
    
    @IBAction func summonCodey(_ sender: Any) {
        
        if(!alreadyPresent){
            let bear = Mascots()
            bear.loadWavingCodey()
            let results = augmentView.hitTest(self.view.center, types: [ARHitTestResult.ResultType.featurePoint])
            guard let hitFeature = results.last else { self.feedback.text = self.feedBox.noSurface() ; toggleFeedbackBox(initializing: false) ; return }
            
            let hitTransform = SCNMatrix4(hitFeature.worldTransform)
            let hitPosition = SCNVector3Make(hitTransform.m41,
                                             hitTransform.m42,
                                             hitTransform.m43)
            
            bear.position = hitPosition
            bear.scale = SCNVector3(0.015, 0.015, 0.015)
            augmentView.scene.rootNode.addChildNode(bear)
            self.feedback.text = feedBox.UGMascotPresent()
            toggleFeedbackBox(initializing: false)
            self.alreadyPresent = true
        }
            
        else{
            feedback.text = feedBox.UGMascotPresent()
            toggleFeedbackBox(initializing:false)
        }
    }
    @IBAction func summonEinstein(_ sender: Any) {
        //TODO Configure addObject() once model available
        feedback.text = feedBox.unsupportedMascot()
        toggleFeedbackBox(initializing:false)
        
    }
    @IBAction func summonAstro(_ sender: Any) {
        //TODO Configure addObject() once model available
        feedback.text = feedBox.unsupportedMascot()
        toggleFeedbackBox(initializing:false)
    }
    
    @IBAction func summonCloudy(_ sender: Any) {
        //TODO Configure addObject() once model available
        feedback.text = feedBox.unsupportedMascot()
        toggleFeedbackBox(initializing:false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: augmentView)
            let hitList = augmentView.hitTest(location, options:nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                
                if node.name == "Codey_The_Bear001"{
                    
                    let bear = Mascots()
                    bear.loadDancingCodey()
                    bear.position = node.position
                    bear.scale = SCNVector3(0.015, 0.015, 0.015)
                    augmentView.scene.rootNode.addChildNode(bear)
                    node.removeFromParentNode()
                }
            }
        }
    }
}


