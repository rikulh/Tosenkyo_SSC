import SwiftUI
import SceneKit

extension simd_float3 {
    static func +(_ lhs: simd_float3,_ rhs: simd_float3) -> simd_float3 {
        return simd_float3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    static func -(_ lhs: simd_float3,_ rhs: simd_float3) -> simd_float3 {
        return simd_float3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    static func *(_ lhs: Float,_ rhs: simd_float3) -> simd_float3 {
        return simd_float3(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    
    var scnVector3: SCNVector3 {
        return SCNVector3(x: self.x, y: self.y, z: self.z)
    }
}

extension SCNVector3 {
    static func +(_ lhs: SCNVector3,_ rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    static func -(_ lhs: SCNVector3,_ rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    static func *(_ lhs: Float,_ rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }
    static func *(_ lhs: SCNVector3,_ rhs: Float) -> SCNVector3 {
        return SCNVector3(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
    }
    static func /(_ lhs: SCNVector3,_ rhs: Float) -> SCNVector3 {
        return SCNVector3(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }
    
    var simd_float3: simd_float3 {
        return SIMD3<Float>(self.x,self.y,self.z)
    }
}

extension CGPoint {
    static func +(_ lhs: CGPoint,_ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func -(_ lhs: CGPoint,_ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func /(_ lhs: CGPoint,_ rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

extension SCNVector4 {
    var simd_float4: simd_float4 {
        return SIMD4<Float>(self.x,self.y,self.z,self.w)
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    static let karakurenai = Color(red: 0.93, green: 0, blue: 0.25)
    static let yamabuki = Color(red: 0.97, green: 0.71, blue: 0)
    static let suou = Color(red: 0.58, green: 0.19, blue: 0.27)
    static let hanada = Color(red: 0, green: 0.53, blue: 0.68)
    static let ginshu = Color(hex: "E24215")!
    static let kusa = Color(hex: "7B8D42")!
    static let murasaki = Color(hex: "884898")!
    static let sohi = Color(hex: "FBA027")!
    static let kikiake = Color(hex: "C20024")!
    static let konnezu = Color(hex: "3F4551")!
}
