import SwiftUI

struct SwipeUpOverLay: View {
    @State var down = true
    var size: CGSize
    var body: some View {
        VStack {
            Image("hand")
                .resizable()
                .opacity(0.5)
                .frame(width: 120,height: 90)
                .position(x: size.width / 2,y: down ? (size.height - 100) : (size.height - 300))
                .animation(.easeInOut(duration: 1).repeatForever(), value: down)
                .onAppear() {
                    down = false
                }
        }
    }
}

struct SwipeUpOverLay_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            SwipeUpOverLay(size: geometry.size)
        }
        .previewDevice("iPhone 14")
    }
}
