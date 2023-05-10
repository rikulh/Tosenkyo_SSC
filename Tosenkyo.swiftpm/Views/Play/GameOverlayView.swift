import SwiftUI

struct GameOverlayView: View {
    var size: CGSize
    @Binding var judgeData: [Int]
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.konnezu)
                    .frame(width: 150)
                    .position(x: size.width - 10,y: 150)
                Circle()
                    .fill(Color.konnezu)
                    .frame(width: 350)
                    .position(x: size.width)
                    .overlay(
                        ZStack {
                            Text("\(judgeData.reduce(0){$0 + (findTrick($1)["point"] as! Int)})")
                                .font(.system(size: 60,weight: .bold))
                                .foregroundColor(.white)
                                .position(x:size.width - 80,y: 60)
                            Text("pts")
                                .font(.system(size: 40,weight: .bold))
                                .foregroundColor(.white)
                                .position(x:size.width - 50,y: 100)
                            Text("\(judgeData.count)/5")
                                .font(.system(size: 30,weight: .bold))
                                .foregroundColor(.white)
                                .position(x:size.width - 35,y: 175)
                        }
                    )
            }
            Spacer()
        }
    }
}

struct GameOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            GameOverlayView(size: geometry.size,judgeData: .constant([0,3,10,10,30]))
        }
        .ignoresSafeArea()
        .previewDevice("iPhone 14")
    }
}
