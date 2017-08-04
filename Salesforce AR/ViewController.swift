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
    @IBOutlet var feedback: UILabel!
    var hiddenPosition: CGPoint!
    var showPosition: CGPoint!
    var feedBox: FeedbackBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeExperience()
    }
    
    func initializeExperience()
    {
        initializeState()
        initializeAlphas()
        initializeAnimations()
    }
    
    fileprivate func initializeState() {
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
        self.feedback.layer.cornerRadius = 5
        self.feedback.layer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
    }
    
    fileprivate func initializeAnimations() {
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
        toggleFeedbackBox()
    }
    
    fileprivate func toggleFeedbackBox(){
        showFeedback()
        hideFeedback()
    }
    
    fileprivate func showFeedback() {
        UIView.animate(withDuration: 1.0, animations: {
            self.feedback.center.y  = self.feedback.center.y + 45
            self.feedback.alpha = 1.0
        })
    }
    
    fileprivate func hideFeedback() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5){
            UIView.animate(withDuration: 1.0, animations: {
                self.feedback.center.y  = self.feedback.center.y - 45
                self.feedback.alpha = 0.0
            })
        }
    }
    
    @IBAction func summonCodey(_ sender: Any) {
        let bear = Mascots()
        bear.loadCody()
        let results = augmentView.hitTest(self.view.center, types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitFeature = results.last else { return }
        
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41,
                                         hitTransform.m42,
                                         hitTransform.m43)
        
        bear.position = hitPosition
        bear.scale = SCNVector3(0.02, 0.02, 0.02)
        augmentView.scene.rootNode.addChildNode(bear)
        
        
    }
    @IBAction func summonEinstein(_ sender: Any) {
        //TODO Configure addObject() once model available
        feedback.text = feedBox.unsupportedMascot()
        toggleFeedbackBox()
        
    }
    @IBAction func summonAstro(_ sender: Any) {
        //TODO Configure addObject() once model available
        feedback.text = feedBox.unsupportedMascot()
        toggleFeedbackBox()
    }
    
    @IBAction func summonCloudy(_ sender: Any) {
        //TODO Configure addObject() once model available
        feedback.text = feedBox.unsupportedMascot()
        toggleFeedbackBox()
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
        UIApplication.shared.isIdleTimerDisabled = true
        return true
    }
}


