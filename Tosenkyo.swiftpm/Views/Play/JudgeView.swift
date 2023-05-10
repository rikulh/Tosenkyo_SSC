import SwiftUI

struct JudgeView: View {
    @Binding var show: Bool
    var data: Int
    var size: CGSize
    @State var dismissDeg: Double = 1
    var completion: () -> Void = {}
    var body: some View {
        ZStack {
            if show {
                Rectangle()
                    .fill(Color(white: 0,opacity: 0.3))
                    .frame(width: size.width,height: size.height)
            }
            ZStack {
                CloudShape()
                    .fill(Color(hex: "FFD700")!)
                    .frame(width: 450,height: 150)
                    .position(x: size.width / 2 - 50,y: size.height / 2 - 150)
                HStack {
                    Text(findTrick(data)["name"] as! String)
                        .foregroundColor(.black)
                        .font(.system(size: 60,weight: .heavy))
                    Spacer()
                }
                .transformEffect(.init(rotationAngle: .pi / -36))
                .frame(width: min(440,size.width * 0.8))
                .position(x: size.width / 2 - 10,y: size.height / 2 - 180)
                Text("\(findTrick(data)["point"] as! Int)pts")
                    .foregroundColor(.black)
                    .font(.system(size: 40,weight: .bold))
                    .position(x: size.width / 2 + 40,y: size.height / 2 - 110)
            }
            .offset(x: -size.width * dismissDeg)
            ZStack {
                CloudShape()
                    .transform(CGAffineTransform(scaleX: 1, y: -1))
                    .fill(Color(hex: "FFD700")!)
                    .frame(width: 450,height: 150)
                    .position(x: size.width / 2 + 40,y: size.height / 2 + 400)
                Rectangle()
                    .fill(Color(hex: "FFD700")!)
                    .frame(width: 300,height: 350)
                    .cornerRadius(20)
                    .position(x: size.width / 2 - 20,y: size.height / 2 + 150)
                VStack {
                    ForEach(trickConditions(data),id: \.self) { val in
                        Text("・\(val)")
                            .foregroundColor(.black)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.vertical,2)
                            .frame(width: 240,alignment: .leading)
                    }
                }
                .frame(width: 270,height: 300)
                .position(x: size.width / 2 - 25,y: size.height / 2 + 130)
            }
            .offset(x: size.width * dismissDeg)
        }
        .onChange(of: show) { val in
            withAnimation(.easeInOut(duration: 0.9)) {
                dismissDeg = show ? 0 : 1
                if show {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            show = false
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
                        completion()
                    }
                }
            }
        }
    }
}

struct JudgeView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            JudgeView(show: .constant(true),data: 4,size: geometry.size)
        }
            .previewDevice("iPhone 14")
    }
}
