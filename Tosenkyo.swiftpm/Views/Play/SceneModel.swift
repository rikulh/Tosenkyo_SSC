import Foundation
import SceneKit
import SwiftUI
import ARKit

class SceneModel: NSObject, SCNSceneRendererDelegate {
    var scene: SCNScene
    var renderer: SCNSceneRenderer?
    
    var thrown: Bool = false
    
    var judgeReady: Bool = false
    
    var judgeCompletion: ((Int) -> Void)?
    
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        self.renderer = renderer
        if let sensu = node("sensu"), let butterfly = node("butterfly") {
            if let sensuBody = sensu.physicsBody, let butterflyBody = butterfly.physicsBody {
                let velocity = simd_length(sensuBody.velocity.simd_float3)
                let butVelocity = simd_length(butterflyBody.velocity.simd_float3)
                node("sensu")?.physicsBody?.applyForce(SCNVector3(0,velocity * velocity * 0.002 + 0.04,0.01 * velocity), asImpulse: false)
                if simd_length(sensu.presentation.simdPosition) >= 10 {
                    ready()
                } else if velocity <= 0.02 && butVelocity <= 0.01 && thrown && sensuBody.type == .dynamic {
                    thrown = false
                    judgeReady = true
                    if judgeCompletion != nil {
                        judgeAnimate()
                        scene.physicsWorld.speed = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                            judgeCompletion!(self.judge())
                        }
                    }
                    node("sensu")?.physicsBody?.type = .static
                }
            }
        }
    }
    
    func node(_ name: String) -> SCNNode? {
        return scene.rootNode.childNode(withName: name, recursively: false)
    }
    
    init(judgeCompletion: ((Int) -> Void)?) {
        scene = SCNScene()
        super.init()
        self.judgeCompletion = judgeCompletion
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 100, z: 100)
        lightNode.name = "light"
        scene.rootNode.addChildNode(lightNode)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.zNear = 0
        cameraNode.position = SCNVector3(x: 0, y: 1, z: 1)
        cameraNode.rotation = SCNVector4(x: 1,y: 0,z: 0,w: -.pi / 3)
        cameraNode.name = "camera"
        scene.rootNode.addChildNode(cameraNode)
        
        let floorGeo = SCNFloor()
        floorGeo.firstMaterial?.diffuse.contents = UIImage(named: "tatami.jpg")
        floorGeo.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(1000, 1000, 0)
        let floorNode = SCNNode(geometry: floorGeo)
        floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: floorGeo))
        floorGeo.name = "floor"
        floorNode.physicsBody?.friction = 2
        scene.rootNode.addChildNode(floorNode)
        
        let carpetGeo = SCNPlane(width: 0.5, height: 2)
        carpetGeo.firstMaterial?.diffuse.contents = UIColor(red: 0.93, green: 0, blue: 0.25, alpha: 1)
        let carpetNode = SCNNode(geometry: carpetGeo)
        carpetNode.name = "carpet"
        carpetNode.physicsBody?.friction = 1
        carpetNode.position = SCNVector3(0,0.0001,0)
        carpetNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: .pi / -2)
        scene.rootNode.addChildNode(carpetNode)
        
        let makura = loadScene(name: "makura.usdz")
        let makuraShape = SCNPhysicsShape(shapes: [SCNPhysicsShape(geometry: SCNBox(width: 0.09, height: 0.175, length: 0.09, chamferRadius: 0.0))], transforms: [SCNMatrix4MakeTranslation(0.0,0.0875,0.0) as NSValue])
        makura!.physicsBody = SCNPhysicsBody(type: .static, shape: makuraShape)
        makura!.name = "makura"
        makura!.physicsBody?.friction = 1
        makura!.physicsBody?.restitution = 0.01
        scene.rootNode.addChildNode(makura!)
        
        let butterfly = loadScene(name: "butterfly.usdz")
        butterfly!.simdPosition = simd_make_float3(0,0.2,0)
        butterfly!.physicsBody = butterflyBody()
        butterfly!.name = "butterfly"
        scene.rootNode.addChildNode(butterfly!)
        
        let sensu = loadScene(name: "sensu.usdz")
        sensu!.simdPosition = simd_make_float3(0,0.5,1)
        sensu!.physicsBody = sensuBody(.kinematic)
        sensu!.name = "sensu"
        scene.rootNode.addChildNode(sensu!)
        
    }
    
    func cam2pos(cam: CGPoint, constraint: Bool = false) -> SCNVector3? {
        if renderer == nil {return nil}
        let height: Float = 0.5
        let cameraNode = self.renderer!.pointOfView!
        let cameraAngle = renderer!.unprojectPoint(SCNVector3(cam.x,cam.y,1)) - cameraNode.presentation.position
        let placePos = cameraNode.presentation.position + ((height - cameraNode.presentation.position.y) / cameraAngle.y) * cameraAngle
        if constraint {
            return SCNVector3(x: placePos.x, y: placePos.y, z: max(0.6,placePos.z))
        }
        return placePos
    }
    
    var dragActive = false
    
    @objc func dragGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            if let camPos = cam2pos(cam: recognizer.location(in: nil)), let sensu = node("sensu") {
                let tapPosition = camPos.simd_float3 - sensu.presentation.simdPosition
                dragActive = simd_length(tapPosition) <= 0.2
                let currentLoc = renderer!.projectPoint(sensu.presentation.position)
                startPos = CGPoint(x: CGFloat(currentLoc.x), y: CGFloat(currentLoc.y))
                thrown = false
            } else {
                break
            }
        case .changed:
            if dragActive {
                self.drag(by: recognizer.translation(in: nil))
                thrown = false
            } else {
                if let camPos = cam2pos(cam: recognizer.location(in: nil)), let sensu = node("sensu") {
                    let tapPosition = camPos.simd_float3 - sensu.presentation.simdPosition
                    dragActive = simd_length(tapPosition) <= 0.2
                    let currentLoc = renderer!.projectPoint(sensu.presentation.position)
                    startPos = CGPoint(x: CGFloat(currentLoc.x), y: CGFloat(currentLoc.y))
                    thrown = false
                }
            }
            break
        case .ended:
            startPos = CGPoint.zero
            if dragActive {
                self.throw(from: recognizer.location(in: nil),velocity: recognizer.velocity(in: nil))
                dragActive = false
            }
            break
        default:
            break
        }
    }
    
    func judgeAnimate() {
        if let camera = renderer?.pointOfView {
            let cameraMove = CABasicAnimation(keyPath: "transform")
            cameraMove.fromValue = camera.presentation.transform
            cameraMove.toValue = SCNMatrix4Mult(SCNMatrix4MakeRotation(.pi / -2, 1, 0, 0),SCNMatrix4MakeTranslation(0, 1, 0))
            cameraMove.duration = 0.7
            cameraMove.autoreverses = false
            camera.addAnimation(SCNAnimation(caAnimation: cameraMove), forKey: "judged")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                camera.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(.pi / -2, 1, 0, 0),SCNMatrix4MakeTranslation(0, 1, 0))
            }
            
        }
    }
    
    func judgeAnimateRevert() {
        if let camera = renderer?.pointOfView {
            let cameraMove = CABasicAnimation(keyPath: "transform")
            cameraMove.fromValue = SCNMatrix4Mult(SCNMatrix4MakeRotation(.pi / -2, 1, 0, 0),SCNMatrix4MakeTranslation(0, 1, 0))
            cameraMove.toValue = SCNMatrix4Mult(SCNMatrix4MakeRotation(.pi / -3, 1, 0, 0), SCNMatrix4MakeTranslation(0, 1, 1))
            cameraMove.duration = 0.7
            cameraMove.autoreverses = false
            camera.addAnimation(SCNAnimation(caAnimation: cameraMove), forKey: "judgedrev")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                camera.transform = SCNMatrix4Mult(SCNMatrix4MakeRotation(.pi / -3, 1, 0, 0), SCNMatrix4MakeTranslation(0, 1, 1))
            }
            
        }
    }
    
    func judge() -> Int {
        if let sensu = node("sensu"), let butterfly = node("butterfly") {
            let btfOrient: simd_quatf = butterfly.presentation.simdOrientation
            let btflyStand: Bool = simd_dot(btfOrient.act(simd_float3(0,1,0)), simd_float3(0,1,0)) >= 0.95
            let btflySit: Bool = butterfly.presentation.position.y >= 0.16
            let btflyHung: Bool = simd_dot(btfOrient.act(simd_float3(0,1,0)), simd_float3(0,1,0)) <= -0.95 && butterfly.presentation.position.y >= 0.1
            let sensuStand: Bool = fabsf(simd_dot(sensu.presentation.simdOrientation.act(simd_float3(0,1,0)),simd_float3(0,1,0))) <= 0.95
            let sensuSit: Bool = sensu.presentation.position.y >= 0.16 && abs(sensu.presentation.simdPosition.x) <= 0.2 && abs(sensu.presentation.simdPosition.z) <= 0.2
            let overlap: Bool? = isFlyUpper(butterfly: butterfly, sensu: sensu)
            var result = btflyHung ? 4 : ((btflySit ? 1 : 0) + (btflyStand ? 2 : 0))
            result *= 3
            result += sensuSit ? 1 : (sensuStand ? 2 : 0)
            result *= 3
            result += overlap == nil ? 0 : (overlap! ? 1 : 2)
            return result
        } else {
            return 0
        }
    }
    
    var startPos = CGPoint.zero
    
    func drag(by trans: CGPoint) {
        let toLoc = startPos + trans
        if let pos = cam2pos(cam: toLoc,constraint: true),let sensu = node("sensu") {
            sensu.physicsBody = sensuBody(.kinematic)
            sensu.position = pos
            sensu.rotation = SCNVector4(0,0,0,0)
        }
    }
    
    func ready(completion: @escaping () -> Void = {}) {
        if let butterfly = node("butterfly"), let sensu = node("sensu") {
            butterfly.position = SCNVector3(0,0.2,0)
            sensu.physicsBody = sensuBody(.kinematic)
            sensu.position = SCNVector3(0,0.5,1)
            sensu.rotation = SCNVector4(x: 1, y: 1, z: 1, w: 0)
            completion()
        }
    }
    
    func adjust(x: Float) -> Float {
        return (tanh(-5 - 100 * x) * 1.3 + 5) * -7 / 400 / x
    }
    
    func `throw`(from location: CGPoint,velocity: CGPoint) {
        if let _ = renderer {
            node("sensu")?.physicsBody = sensuBody(.dynamic)
            node("sensu")?.position = cam2pos(cam: location,constraint: true)!
            let power = (cam2pos(cam: (location + (velocity / 20)))! - cam2pos(cam: location)!) / 5
            let adjustedPower = power * adjust(x: power.z)
            node("sensu")?.physicsBody?.applyForce(adjustedPower, asImpulse: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                thrown = true
                if thrown {
                    self.node("sensu")?.physicsBody?.applyTorque(SCNVector4(1, 0, 0, 0.002), asImpulse: true)
                }
            }
        }
    }
}

