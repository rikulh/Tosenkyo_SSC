import SwiftUI

struct ResultView: View {
    @Binding var tricks: [Int]
    @Binding var show: Bool
    var size: CGSize
    var completion: (Int) -> Void = {sum in }
    var sum: Int {
        var result = 0
        for trick in tricks {
            result += findTrick(trick)["point"] as! Int
        }
        return result
    }
    var body: some View {
        ZStack {
            MakimonoView(size: CGSize(width: size.width, height: size.height * 0.8))
                .offset(y: size.height * 0.1)
            VStack {
                Text("Result")
                    .foregroundColor(.black)
                    .font(Font.largeTitle)
                    .fontWeight(.heavy)
                VStack(spacing: 5) {
                    ForEach(Array(tricks.enumerated()),id: \.offset) { index, trick in
                        HStack {
                            Text("\(index + 1)")
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                                .padding(10)
                            Text(findTrick(trick)["name"] as! String)
                                .foregroundColor(.black)
                                .padding(10)
                            Spacer()
                            Text("\(findTrick(trick)["point"] as! Int)pts")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(10)
                        }
                        .padding(.horizontal,size.width * 0.2)
                        .padding(.vertical,0)
                    }
                    HStack {
                        Text("Sum")
                            .fontWeight(.heavy)
                            .foregroundColor(Color.red)
                            .padding(10)
                        Spacer()
                        Text("\(sum)pts")
                            .fontWeight(.bold)
                            .foregroundColor(Color.red)
                            .padding(10)
                    }
                    .padding(.horizontal,size.width * 0.2)
                    .padding(.vertical,0)
                }
                HStack {
                    Spacer()
                    Button {
                        show = false
                        completion(sum)
                    } label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .tint(Color.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,30)
                            .background(.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.horizontal,50)
                .padding(.top,20)
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ResultView(tricks: .constant([0,15,18,26,34]),show: .constant(true), size: geometry.size)
        }
        .previewDevice("iPad")
    }
}
