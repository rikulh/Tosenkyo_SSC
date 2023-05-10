import SwiftUI
import SceneKit

struct GameView: View {
    @State var sceneModel = SceneModel(judgeCompletion: nil)
    @State var showResult = false
    
    @State var judgeData: [Int] = []
    @GestureState var translation: CGSize = .zero
    @Binding var moveTo: Presentation
    @State var showJudge = false
    @Binding var highScore: Int
    @Binding var achieved: [Int]
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SCNCustomView(judgeData: $judgeData, sceneModel: $sceneModel,completion: {
                    withAnimation {
                        showJudge = true
                    }
                })
                if showResult && judgeData.count >= 5 {
                    Rectangle()
                        .fill(Color(white: 0,opacity: 0.5))
                        .frame(width: geometry.size.width,height: geometry.size.height)
                }
                GameOverlayView(size: geometry.size, judgeData: $judgeData)
                JudgeView(show: $showJudge, data: judgeData.last ?? 0, size: geometry.size,completion: {
                    if (achieved.firstIndex(of: judgeData.last ?? 0) == nil) {
                        achieved.append(judgeData.last ?? 0)
                    }
                    sceneModel.judgeAnimateRevert()
                    sceneModel.ready()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        sceneModel.ready()
                    })
                    sceneModel.scene.physicsWorld.speed = 1
                    if judgeData.count >= 5 {
                        showResult = true
                    }
                })
                if showResult && judgeData.count >= 5 {
                    ResultView(tricks: $judgeData, show: $showResult, size: geometry.size,completion: { sum in
                        sceneModel.ready()
                        if highScore < sum {
                            highScore = sum
                        }
                        judgeData = []
                    })
                }
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
            }
        }
        .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(moveTo: .constant(.play), highScore: .constant(100), achieved: .constant([]))
            .previewDevice("iPhone 14")
    }
}
