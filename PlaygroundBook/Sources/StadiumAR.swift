//
//  StadiumAR.swift
//  Book_Sources
//
//  Created by Arthur Melo on 22/03/19.
//

import UIKit
import ARKit
import SceneKit
import PlaygroundSupport

class StadiumViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    let session = ARSession()
    let sceneView = ARSCNView()
    var audioSource: SCNAudioSource!
    var resetButton: UIButton?
    var plane: SCNNode?

    override func viewDidLoad() {
        let scene = SCNScene()
        sceneView.scene = scene

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal

        sceneView.delegate = self
        sceneView.session = session
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

        sceneView.session.delegate = self
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.isUserInteractionEnabled = true
        
        self.view.isUserInteractionEnabled = true
        
        self.view = sceneView
        setUpAudio()
        addTapGestureToSceneView()
        addResetButton()
        sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func addResetButton() {
        let resetButton = UIButton(frame: CGRect(x: 20, y: 20, width: 120, height: 100))
        resetButton.backgroundColor = .gray
        resetButton.backgroundColor?.withAlphaComponent(0.5)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.addTarget(self, action: #selector(resetScene), for: .touchUpInside)
        self.sceneView.addSubview(resetButton)
    }
    
    @objc func resetScene() {
        sceneView.scene.rootNode.enumerateChildNodes({ (node, stop) in
            node.removeFromParentNode()
            node.removeAllAudioPlayers()
        })
    }
    
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        guard let shipScene = SCNScene(named: "stadium.scn"),
            let shipNode = shipScene.rootNode.childNode(withName: "stadium", recursively: false)
            else { return }
        
        shipNode.scale = SCNVector3(0.02, 0.02, 0.02)
        shipNode.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(shipNode)
        self.plane?.removeFromParentNode()
        playSound(node: shipNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        plane.materials.first?.diffuse.contents = UIColor.lightGray.withAlphaComponent(0.5)
        
        let planeNode = SCNNode(geometry: plane)
        
        let x = CGFloat(planeAnchor.center.x)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,CGFloat(planeNode.position.y),z)
        planeNode.eulerAngles.x = -.pi / 2
        
        self.plane = planeNode
        node.addChildNode(self.plane!)
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addShipToSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setUpAudio() {
        audioSource = SCNAudioSource(fileNamed: "caza.aiff")!
        audioSource.loops = true
        audioSource.isPositional = true
        audioSource.volume = 0.5
        audioSource.load()
    }
    
    private func playSound(node: SCNNode) {
        node.removeAllAudioPlayers()
        node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
