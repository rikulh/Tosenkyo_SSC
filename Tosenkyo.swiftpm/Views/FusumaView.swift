import SwiftUI

struct FusumaView: View {
    let size: CGSize
    @State var openDeg: Double = 1
    @Binding var transit: Bool
    var refresh: () -> Void = {}
    var body: some View {
        ZStack {
            FusumaDoor(size: size,reverse: false)
                .position(x: 0 - size.width / 2 * openDeg,y: size.height / 2)
            FusumaDoor(size: size,reverse: true)
                .position(x: size.width + size.width / 2 * openDeg,y: size.height / 2)
        }
        .onChange(of: transit) { val in
            withAnimation(.timingCurve(0.19, 0, 0.53, 0.02,duration: 0.4)){
                openDeg = transit ? 0 : 1
                if transit {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        refresh()
                        transit = false
                    }
                }
            }
        }
    }
}
