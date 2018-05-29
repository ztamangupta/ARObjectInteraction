//
//  ViewController.swift
//  frostrum view
//
//  Created by Abhishek Purohit on 21/05/18.
//  Copyright © 2018 Abhishek Purohit. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let falseButton = SCNNode();
    let trueButton = SCNNode();
    
    
    //    create correct/wrong answer labels ivars and add to viewdidload
    var truelabel = UILabel()
    var falselabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        createTrueOrFalseMenuWithText()
        detectButtonInFrostrumOfCamera()
        
        //  true label
        
        truelabel.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
        truelabel.text = "Correct Answer"
        truelabel.center = CGPoint(x: 200, y: 50)
        truelabel.textAlignment = .center
        truelabel.textColor = UIColor.green
        truelabel.font = UIFont(name: "Avenir next", size: 25)
        
        // false label
        
        falselabel.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
        falselabel.text = "Wrong Answer"
        falselabel.center = CGPoint(x: 200, y: 50)
        falselabel.textAlignment = .center
        falselabel.textColor = UIColor.red
        falselabel.font = UIFont(name: "Avenir next", size: 25)
        
    }
    
    
    
    
    
    
    
    func createTrueOrFalseMenuWithText(){
        
        //1. Create A Menu Holder
        let menu = SCNNode()
        
        //2. Create A True Button With An SCNText Geometry & Green Colour
        let trueTextGeometry = SCNText(string: "True" , extrusionDepth: 1)
        trueTextGeometry.font = UIFont(name: "Helvatica", size: 3)
        trueTextGeometry.flatness = 0
        trueTextGeometry.firstMaterial?.diffuse.contents = UIColor.green
        trueButton.geometry = trueTextGeometry
        trueButton.scale = SCNVector3(0.01, 0.01 , 0.01)
        trueButton.name = "True"
        
        //3. Create A False Button With An SCNText Geometry & Red Colour
        
        let falseTextGeometry = SCNText(string: "False" , extrusionDepth: 1)
        falseTextGeometry.font = UIFont(name: "Helvatica", size: 3)
        falseTextGeometry.flatness = 0
        falseTextGeometry.firstMaterial?.diffuse.contents = UIColor.red
        falseButton.geometry = falseTextGeometry
        falseButton.scale = SCNVector3(0.01, 0.01 , 0.01)
        falseButton.name = "False"
        
        //4. Set The Buttons Postions
        trueButton.position = SCNVector3(-0.9,0,0)
        falseButton.position = SCNVector3(0.9,0,0)
        
        //5. Add The Buttons To The Menu Node & Set Its Position
        menu.addChildNode(trueButton)
        menu.addChildNode(falseButton)
        menu.position = SCNVector3(0,0, -1.5)
        
        //6. Add The Menu To The View
        sceneView.scene.rootNode.addChildNode(menu)
    }
    
    
    

    
    
    
    
    
    
    /// Detects If An Object Is In View Of The Camera Frostrum
    func detectButtonInFrostrumOfCamera(){
        
        //1. Get The Current Point Of View
        if let currentPointOfView = sceneView.pointOfView{
            
            if sceneView.isNode(trueButton, insideFrustumOf: currentPointOfView){
                
                
                print("True Button Has Been Selected As The Answer")
                
                DispatchQueue.main.async {
                    self.truelabel.isHidden = false
                    self.view.addSubview(self.truelabel)
                    self.falselabel.isHidden = true
                }
                
                
                
                //view.addSubview(falselabel)
                
            }
            
            if sceneView.isNode(falseButton, insideFrustumOf: currentPointOfView){
                
                print("False Button Has Been Selected As The Answer")
                
                DispatchQueue.main.async {
                    self.truelabel.isHidden = true
                    self.view.addSubview(self.falselabel)
                    self.falselabel.isHidden = false
                }
            }
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        detectButtonInFrostrumOfCamera()
        
    }
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

