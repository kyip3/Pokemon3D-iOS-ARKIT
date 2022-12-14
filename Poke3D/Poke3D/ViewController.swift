//
//  ViewController.swift
//  Poke3D
//
//  Created by yip kayan on 16/8/22.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        

        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("images successfully added.")
        }
        
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            

            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)

            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -Float.pi/2
            
            node.addChildNode(planeNode)
            
            
            print("image anchor \(imageAnchor.referenceImage)")
            
            var scnasset:String = ""
            
            if(imageAnchor.referenceImage.name == "eevee-card"){
                
                scnasset = "art.scnassets/eevee.scn"
                
//                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn"){
//
//                    if let pokeNode = pokeScene.rootNode.childNodes.first {
//
//                        pokeNode.eulerAngles.x = Float.pi/2
//
//                        planeNode.addChildNode(pokeNode)
//                    }
//                }
            } else if(imageAnchor.referenceImage.name == "flareon-card"){
                scnasset = "art.scnassets/flareon.scn"
//                if let pokeScene = SCNScene(named: "art.scnassets/flareon.scn"){
//
//                    if let pokeNode = pokeScene.rootNode.childNodes.first {
//
//                        pokeNode.eulerAngles.x = Float.pi/2
//
//                        planeNode.addChildNode(pokeNode)
//                    }
//                }
            }
            
            if let pokeScene = SCNScene(named: scnasset){

                    if let pokeNode = pokeScene.rootNode.childNodes.first {

                        pokeNode.eulerAngles.x = Float.pi/2

                        planeNode.addChildNode(pokeNode)
                    }
                }
        }
        
        return node
    }
}
