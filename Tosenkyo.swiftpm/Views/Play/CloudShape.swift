import SwiftUI

struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.21609*height))
        path.addCurve(to: CGPoint(x: 0.07022*width, y: 0), control1: CGPoint(x: 0, y: 0.09675*height), control2: CGPoint(x: 0.03144*width, y: 0))
        path.addLine(to: CGPoint(x: 0.92978*width, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.21609*height), control1: CGPoint(x: 0.96856*width, y: 0), control2: CGPoint(x: width, y: 0.09675*height))
        path.addCurve(to: CGPoint(x: 0.92978*width, y: 0.43219*height), control1: CGPoint(x: width, y: 0.33544*height), control2: CGPoint(x: 0.96856*width, y: 0.43219*height))
        path.addLine(to: CGPoint(x: 0.7183*width, y: 0.43219*height))
        path.addCurve(to: CGPoint(x: 0.69626*width, y: 0.5*height), control1: CGPoint(x: 0.70613*width, y: 0.43219*height), control2: CGPoint(x: 0.69626*width, y: 0.46255*height))
        path.addCurve(to: CGPoint(x: 0.7183*width, y: 0.56781*height), control1: CGPoint(x: 0.69626*width, y: 0.53745*height), control2: CGPoint(x: 0.70613*width, y: 0.56781*height))
        path.addLine(to: CGPoint(x: 0.84371*width, y: 0.56781*height))
        path.addCurve(to: CGPoint(x: 0.91392*width, y: 0.78391*height), control1: CGPoint(x: 0.88249*width, y: 0.56781*height), control2: CGPoint(x: 0.91392*width, y: 0.66456*height))
        path.addCurve(to: CGPoint(x: 0.84371*width, y: height), control1: CGPoint(x: 0.91392*width, y: 0.90325*height), control2: CGPoint(x: 0.88249*width, y: height))
        path.addLine(to: CGPoint(x: 0.15612*width, y: height))
        path.addCurve(to: CGPoint(x: 0.08591*width, y: 0.78391*height), control1: CGPoint(x: 0.11734*width, y: height), control2: CGPoint(x: 0.08591*width, y: 0.90325*height))
        path.addCurve(to: CGPoint(x: 0.15612*width, y: 0.56781*height), control1: CGPoint(x: 0.08591*width, y: 0.66456*height), control2: CGPoint(x: 0.11734*width, y: 0.56781*height))
        path.addLine(to: CGPoint(x: 0.34971*width, y: 0.56781*height))
        path.addCurve(to: CGPoint(x: 0.37174*width, y: 0.5*height), control1: CGPoint(x: 0.36188*width, y: 0.56781*height), control2: CGPoint(x: 0.37174*width, y: 0.53745*height))
        path.addCurve(to: CGPoint(x: 0.34971*width, y: 0.43219*height), control1: CGPoint(x: 0.37174*width, y: 0.46255*height), control2: CGPoint(x: 0.36188*width, y: 0.43219*height))
        path.addLine(to: CGPoint(x: 0.07022*width, y: 0.43219*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.21609*height), control1: CGPoint(x: 0.03144*width, y: 0.43219*height), control2: CGPoint(x: 0, y: 0.33544*height))
        path.closeSubpath()
        return path
    }
}
