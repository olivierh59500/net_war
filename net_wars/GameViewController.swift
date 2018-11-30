import UIKit
import SceneKit
import CoreMotion

class GameViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    let cameraNode = SCNNode()
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var scene: SCNScene!
    @IBOutlet var hud: OverlayScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        self.hud = OverlayScene(size: self.view.bounds.size)
        self.sceneView.overlaySKScene = self.hud
    }
    
    func setupScene(){
        // Scene and View
        sceneView = self.view as! SCNView
        sceneView.delegate = self
        let scene = SCNScene(named: "art.scnassets/level.scn")
        sceneView.scene = scene
        
        // Camera
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        scene?.rootNode.addChildNode(cameraNode)
        
        guard motionManager.isDeviceMotionAvailable else {
            fatalError("Device motion is not available")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GameViewController : SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
            data , error in
            
            guard let data = data else { return }
            
            let attitude: CMAttitude = data.attitude
            self.cameraNode.eulerAngles = SCNVector3Make(Float(attitude.roll - M_PI/2.0), Float(attitude.yaw), Float(attitude.pitch))
            self.cameraNode.simdPosition += self.cameraNode.simdWorldFront
            //print(data.attitude)
            print("Height: " , self.self.sceneView.frame.height)
            print("Width: " , self.sceneView.frame.width)

        })
    }
}

