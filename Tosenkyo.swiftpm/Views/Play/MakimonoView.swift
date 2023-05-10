import SwiftUI

struct MakimonoView: View {
    var size: CGSize
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.22, green: 0.49, blue: 0.19))
                .frame(width: size.width * 0.8,height: size.height - 20)
                .position(x: size.width * 0.5,y: size.height / 2 + 10)
            Rectangle()
                .fill(Color(red: 0.87, green: 0.76, blue: 0.64))
                .frame(width: size.width * 0.8 - 20,height: size.height - 16)
                .position(x: size.width * 0.5 + 1,y: size.height / 2)
            Rectangle()
                .fill(Color(red: 0.22, green: 0.49, blue: 0.19))
                .frame(width: size.width * 0.8,height: 40)
                .position(x: size.width * 0.5 + 15,y: 20)
            Ellipse()
                .fill(Color(red: 0.52, green: 0.67, blue: 0.32))
                .frame(width: 30,height: 40)
                .position(x: size.width * 0.1 + 15,y: 20)
            Rectangle()
                .fill(Color(red: 0.52, green: 0.67, blue: 0.32))
                .frame(width: 4,height: size.height - 20)
                .position(x: size.width * 0.1 + 2,y: size.height / 2 + 10)
            Ellipse()
                .fill(Color(red: 0.22, green: 0.49, blue: 0.19))
                .frame(width: 30,height: 40)
                .position(x: size.width * 0.9 + 15,y: 20)
            Ellipse()
                .fill(Color(red: 0.87, green: 0.76, blue: 0.64))
                .frame(width: 21,height: 28)
                .position(x: size.width * 0.1 + 15,y: 20)
            Ellipse()
                .fill(Color(red: 0.26, green: 0.17, blue: 0.09))
                .frame(width: 12,height: 16)
                .position(x: size.width * 0.1 + 14,y: 20)
            Rectangle()
                .fill(Color(red: 0.26, green: 0.17, blue: 0.09))
                .frame(width: 15,height: 16)
                .position(x: size.width * 0.1 + 7,y: 20)
            Ellipse()
                .fill(Color(red: 0.43, green: 0.36, blue: 0.30))
                .frame(width: 12,height: 16)
                .position(x: size.width * 0.1,y: 20)
        }
    }
}

struct MakimonoView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            MakimonoView(size: geometry.size)
        }
            .previewDevice("iPhone 14")
    }
}
