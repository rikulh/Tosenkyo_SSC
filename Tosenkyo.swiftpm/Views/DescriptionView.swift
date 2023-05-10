import SwiftUI

struct DescriptionView: View {
    @Binding var moveTo: Presentation
    var body: some View {
        VStack {
            HStack {
                    Button() {
                        moveTo = .main
                    } label: {
                        Rectangle()
                            .fill(Color.konnezu)
                            .overlay(
                                Image(systemName: "arrow.backward")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 30,height: 30)
                                    .cornerRadius(20)
                                    .position(x: 140, y: 140)
                            )
                    }
                    .clipShape(Circle())
                    .frame(width: 200,height: 200)
                    .position(x:0,y:0)
                Spacer()
            }
            .frame(height: 100)
            ScrollView() {
                VStack(alignment: .leading) {
                    Text("Introduce")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("    Tosenkyo is a traditional game from Kyoto.\nThe game was really popular among common people in Edo era, and once it was banned because it was used as gambling.")
                    .font(.title2)
                    .fontWeight(.medium)
                    Text("Set")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("・Sensu: This is a light-weight holding fan.")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("・Cho: This is the target.\nThe shape is inspired by butterflies.")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("・Makura: This is a box made of wood.")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("Rule")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("    Swipe up and throw the sensu toward the cho, and try to strike it.\nYou will get points depending on the positional relationship between the sensu and the cho and the makura.\nEach pattern of the positional relationships has a name such as \"Miotsukushi\" or \"Hanachirusato\"\nFor more examples, visit\"Tricks.\"")
                    .font(.title2)
                    .fontWeight(.medium)
                    Spacer()
                }
                .foregroundColor(.black)
                .padding(.horizontal,30)
                .padding(.bottom,50)
            }
        }
        .background(Color.white)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(moveTo: .constant(.description))
            .previewDevice("iPhone 14")
    }
}
