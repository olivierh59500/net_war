import UIKit
import SceneKit
import CoreMotion

class GameViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    let cameraNode = SCNNode()
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var scene: SCNScene!
    
    var firebutton: UIButton!
    var thruster: UISlider!
    
    
    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        //super.viewDidLoad()
        setupScene()
    
    }
    
    func setupScene(){
        
        // Set the scene
        sceneView = self.view as! SCNView
        sceneView.delegate = self
        let scene = SCNScene(named: "art.scnassets/level.scn")
        sceneView.scene = scene
        
        // Camera, ...
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        scene?.rootNode.addChildNode(cameraNode)
        
        guard motionManager.isDeviceMotionAvailable else {
            fatalError("Device motion is not available")
        }
        
        /*
        // Action
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {
            data , error in
            
            guard let data = data else { return }
            
            let attitude: CMAttitude = data.attitude
            self.cameraNode.eulerAngles = SCNVector3Make(Float(attitude.roll - M_PI/2.0), Float(attitude.yaw), Float(attitude.pitch))
            print(data.attitude)
            
        })
         */
        
        // Fire button setup
        let firebutton:UIButton = UIButton(frame: CGRect(x: sceneView.frame.height * 0.80, y: sceneView.frame.width * 0.35, width: 100, height: 100))
            firebutton.backgroundColor = .gray
            firebutton.setTitle("Fire", for: .normal)
            firebutton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            sceneView.addSubview(firebutton)
        
        // Thruster setup
        let thruster: UISlider = UISlider(frame: CGRect(x: sceneView.frame.height * 0.01, y: sceneView.frame.width * 0.50, width: 150, height: 20))
            thruster.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
            thruster.minimumValue = 0
            thruster.maximumValue = 100
            thruster.isContinuous = true
            thruster.tintColor = UIColor.yellow
            sceneView.addSubview(thruster)
        
        
        
        //let firebutton:UIButton = UIButton(frame: CGRect(x: sceneView.frame.height * 0.80, y: //sceneView.frame.width * 0.35, width: 100, height: 100))
        
        //let thruster: UISlider = UISlider(frame: CGRect(x: sceneView.frame.height * 0.05, y: //sceneView.frame.width * 0.45, width: 150, height: 20))
    }
    
    @objc func buttonClicked() {
        print("BAM!")
    }
    
    func sliderValueDidChange(_ sender:UISlider!)
    {
        print("Slider value changed")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var shouldAutorotate: Bool {
        return true
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
            //print(data.attitude)
            print("Height: " , self.self.sceneView.frame.height)
            print("Width: " , self.sceneView.frame.width)

        })
    }
}

