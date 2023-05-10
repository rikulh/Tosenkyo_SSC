import SwiftUI
import SceneKit


func isFlyUpper(butterfly: SCNNode, sensu: SCNNode) -> Bool? {
    let btfPosW = butterfly.presentation.simdPosition + butterfly.presentation.simdOrientation.act(simd_float3(0,0.01,0))
    let sensuPosW = sensu.presentation.simdPosition
    let sensuNormal = sensu.presentation.simdOrientation.act(simd_float3(0,1,0))
    let centerBone = sensu.presentation.simdOrientation.act(simd_float3(0,0,-1))
    let btfNormal = simd_project(btfPosW - sensu.presentation.simdPosition,sensuNormal)
    let ratio = btfNormal.y / simd_project(simd_float3(0,1,0), sensuNormal).y * -1
    let btfPerpend = btfPosW + ratio * simd_float3(x: 0, y: 1, z: 0)
    let btfPerpPosS = btfPerpend - sensuPosW
    if simd_length(btfPerpPosS) <= 0.15 && simd_dot(centerBone,btfPerpPosS) / simd_length(btfPerpPosS) >= 0.1736 {
        return ratio < 0
    }
    return nil
}
var butterflyShape: SCNPhysicsShape {
    var shapes: [SCNGeometry] = []
    var transforms: [SCNMatrix4] = []
    
    //base
    shapes.append(SCNCylinder(radius: 0.0142, height: 0.0092))
    transforms.append(SCNMatrix4MakeTranslation(0, 0, 0))
    
    //center
    shapes.append(SCNBox(width: 0.0152, height: 0.0744, length: 0.008, chamferRadius: 0))
    transforms.append(SCNMatrix4MakeTranslation(0, 0.0464, 0))
    
    let data: [[CGFloat]] = [[0.0152,0.0198,25.11,0.0127,0.0714],[0.0152,0.0283,42.0,0.0175,0.0616],[0.0152,0.0373,58.84,0.0205,0.0511],[0.0152,0.0327,74.05,0.0268,0.0424],[0.008,0.0382,84.83,0.026,0.0341]]
    for datum in data {
        shapes.append(SCNBox(width: datum[0], height: datum[1], length: 0.008, chamferRadius: 0))
        transforms.append(SCNMatrix4Translate(SCNMatrix4MakeRotation(.pi / 360 * Float(datum[2]), 0, 0, 1), Float(datum[3]), Float(datum[4]), 0))
        
        shapes.append(SCNBox(width: datum[0], height: datum[1], length: 0.008, chamferRadius: 0))
        transforms.append(SCNMatrix4Translate(SCNMatrix4MakeRotation(.pi / -360 * Float(datum[2]), 0, 0, 1), -Float(datum[3]), Float(datum[4]), 0))
    }
    return SCNPhysicsShape(shapes: shapes.map{SCNPhysicsShape(geometry: $0)}, transforms: transforms.map{$0 as NSValue})
}

var sensuShape: SCNPhysicsShape {
    var shapes: [SCNGeometry] = []
    var transforms: [SCNMatrix4] = []
    shapes.append(SCNCylinder(radius: 0.02, height: 0.025))
    transforms.append(SCNMatrix4MakeTranslation(0, 0.0025, 0))
    let data = [[0.0162,0.1496,77.1,0.0718,0.0246],[0.02761,0.0694,66.42,0.1066,0.0450],[0.02761,0.0997,57.01,0.0835,0.0560],[0.02761,0.1143,44.77,0.0679,0.0638],[0.02761,0.1298,35.38,0.0496,0.0692],[0.02761,0.1086,25.04,0.0404,0.0868],[0.02761,0.0986,14.17,0.0254,0.0974],[0.02761,0.1382,4.03,0.0055,0.0806]]
    for datum in data {
        shapes.append(SCNBox(width: datum[0], height: 0.025, length: datum[1], chamferRadius: 0))
        transforms.append(SCNMatrix4Translate(SCNMatrix4MakeRotation(.pi / 360 * Float(datum[2]), 0, 1, 0), Float(datum[3]), 0.0025, -Float(datum[4])))
        
        shapes.append(SCNBox(width: datum[0], height: 0.025, length: datum[1], chamferRadius: 0))
        transforms.append(SCNMatrix4Translate(SCNMatrix4MakeRotation(.pi / -360 * Float(datum[2]), 0, 1, 0), -Float(datum[3]), 0.0025, -Float(datum[4])))
    }
    return SCNPhysicsShape(shapes: shapes.map{SCNPhysicsShape(geometry: $0)}, transforms: transforms.map {return $0 as NSValue})
}

func sensuBody(_ type: SCNPhysicsBodyType) -> SCNPhysicsBody {
    let physicsBody = SCNPhysicsBody(type: type, shape: sensuShape)
    physicsBody.restitution = 0.1
    physicsBody.friction = 1
    physicsBody.angularDamping = 0.99
    physicsBody.centerOfMassOffset = SCNVector3(0,0,-0.04)
    physicsBody.mass = 0.02
    physicsBody.restitution = 0.01
    return physicsBody
}

func butterflyBody() -> SCNPhysicsBody {
    let physicsBody = SCNPhysicsBody(type: .dynamic, shape: butterflyShape)
    physicsBody.restitution = 0.1
    physicsBody.friction = 1
    physicsBody.centerOfMassOffset = SCNVector3(0,0.017,0)
    physicsBody.mass = 0.06
    physicsBody.restitution = 0.01
    return physicsBody
}

func loadScene(name: String) -> SCNNode? {
    return SCNScene(named: name)?.rootNode.childNodes.first?.childNodes.first?.childNodes.first
}
