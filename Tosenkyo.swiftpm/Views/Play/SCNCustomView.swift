import SwiftUI
import SceneKit
import UIKit


struct SCNCustomView: UIViewRepresentable {
    @Binding var judgeData: [Int]
    @Binding var sceneModel: SceneModel
    var completion: () -> Void = {}
    
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView(frame: .zero)
        scnView.scene = self.sceneModel.scene
        scnView.delegate = self.sceneModel
        scnView.pointOfView = sceneModel.scene.rootNode.childNode(withName: "camera", recursively: false)
        scnView.autoenablesDefaultLighting = true
        let gesture = UIPanGestureRecognizer(target: sceneModel, action: #selector(sceneModel.dragGesture(_:)))
        gesture.maximumNumberOfTouches = 1
        scnView.addGestureRecognizer(gesture)
        scnView.allowsCameraControl = true
        sceneModel.judgeCompletion = judge(data:)
        return scnView
    }
    
    func judge(data: Int) {
        judgeData.append(data)
        completion()
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
} 
