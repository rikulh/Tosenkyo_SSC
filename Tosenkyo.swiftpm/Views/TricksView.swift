import SwiftUI

struct TricksView: View {
    @Binding var moveTo: Presentation
    let columns = [GridItem(.adaptive(minimum: 120))]
    var judgeKeys: [[Int]] {
        var result:[[Int]] = []
        for key in judgeTable.keys {
            result.append(key)
        }
        return result.sorted(by: {judgeTable[$1]!["point"] as! Int > judgeTable[$0]!["point"] as! Int})
    }
    @Binding var achieved: [Int]
    let colors: [Color] = [.karakurenai,.yamabuki,.suou,.hanada,.ginshu,.kusa,.murasaki,.sohi,.kikiake]
    var body: some View {
        ZStack {
            ScrollView() {
                LazyVGrid(columns: columns) {
                    ForEach(judgeKeys, id: \.self) { key in
                            VStack {
                                HStack {
                                    Text(findTrick(key.first!)["name"] as! String)
                                        .foregroundColor(.black)
                                        .font(.system(size: 17))
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .padding(.leading,10)
                                HStack {
                                    Text("\(findTrick(key.first!)["point"] as! Int)pts")
                                        .foregroundColor(.black)
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                .padding(.leading,10)
                                Image(findTrick(key.first!)["name"] as! String)
                                    .resizable()
                                    .frame(width: 80,height: 65)
                                    .cornerRadius(5)
                            }
                            .padding(.vertical,10)
                            .background(achieved.firstIndex(where: { val in
                                return key.firstIndex(of: val) != nil
                            }) != nil ? colors[(key.reduce(0, +) * 4) % colors.count] : Color(red: 0.9, green: 0.9, blue: 0.92))
                            .cornerRadius(10)
                    }
                }
                .padding(.top,110)
                .padding(.bottom,50)
                .padding(.horizontal,5)
            }
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
        }
        .background(Color.white)
    }
}

struct TricksView_Previews: PreviewProvider {
    static var previews: some View {
        TricksView(moveTo: .constant(.trick), achieved: .constant([]))
            .previewDevice("iPhone 14")
    }
}
