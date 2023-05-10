import SwiftUI

struct FusumaDoor: View {
    let size: CGSize
    let reverse: Bool
    var body: some View {
        ZStack {
            Text("heijhi")
            Rectangle()
                .fill(LinearGradient(colors: [Color(hex: "DAB670")!,Color(hex: "DEB25C")!], startPoint: .top, endPoint: .bottom))
                .frame(width: size.width,height: size.height)
                .border(Color(red: 0.04, green: 0, blue: 0.13), width: size.width * 0.03)
            Rectangle()
                .fill(LinearGradient(colors: [Color(hex: "B56114")!,Color(hex: "A75000")!], startPoint: .top, endPoint: .bottom))
                .frame(width: size.width * 0.94,height: size.height * 0.2)
                .position(x: size.width / 2,y: size.height * 0.65)
            if reverse {
                Circle()
                    .fill(Color(red: 0.04, green: 0, blue: 0.13))
                    .frame(width: size.width * 0.1,height: size.width * 0.1)
                    .position(x: size.width * 0.11,y: size.height * 0.53 - size.width * 0.05)
            } else {
                Circle()
                    .fill(Color(red: 0.04, green: 0, blue: 0.13))
                    .frame(width: size.width * 0.1,height: size.width * 0.1)
                    .position(x: size.width * 0.89,y: size.height * 0.53 - size.width * 0.05)
            }
            
        }
    }
}


struct FusumaDoor_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            FusumaDoor(size: geometry.size, reverse: true)
        }
        .previewDevice("iPhone 14")
        GeometryReader { geometry in
            FusumaDoor(size: geometry.size, reverse: true)
        }
        .previewDevice("iPad Pro")
    }
}
