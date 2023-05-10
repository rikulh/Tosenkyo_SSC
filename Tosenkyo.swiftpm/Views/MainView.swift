import SwiftUI

struct MainView: View {
    @Binding var moveTo: Presentation
    @State var backPos = 0
    @Binding var highScore: Int
    var body: some View {
        VStack() {
            Spacer()
            VStack {
                Text("Tosenkyo")
                    .foregroundColor(.black)
                    .font(.system(size: 70,weight: .bold))
                Text("High score: \(highScore)")
                    .foregroundColor(.black)
                    .font(.system(size: 40,weight: .medium))
            }
            .padding(.bottom,300)
            VStack(spacing: 10) {
                Button {
                    moveTo = .description
                } label: {
                    Text("About Tosenkyo")
                        .font(.system(size: 30,weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 80)
                        .background(Color.suou)
                        .cornerRadius(20)
                }
                Button {
                    moveTo = .play
                } label: {
                    Text("Play")
                        .font(.system(size: 30,weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 80)
                        .background(Color.yamabuki)
                        .cornerRadius(20)
                }
                Button {
                    moveTo = .trick
                } label: {
                    Text("Tricks")
                        .font(.system(size: 30,weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 300, height: 80)
                        .background(Color.hanada)
                        .cornerRadius(20)
                }
            }
            Spacer()
        }
        .background() {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(moveTo: .constant(.main), highScore: .constant(100))
            .previewDevice("iPhone 14")
    }
}
