import SwiftUI
import SceneKit
import AVFoundation

struct ContentView: View {
    @State var moveTo: Presentation = .main
    @State var presentation: Presentation = .main
    @State var fusumaTransit: Bool = false
    @State var audioPlayer: AVAudioPlayer?
    @State var highScore: Int = 0
    @State var achieved: [Int] = []
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch presentation {
                case .main:
                    MainView(moveTo: $moveTo,highScore: $highScore)
                case .play:
                    GameView(moveTo: $moveTo, highScore: $highScore, achieved: $achieved)
                case .description:
                    DescriptionView(moveTo: $moveTo)
                case .trick:
                    TricksView(moveTo: $moveTo, achieved: $achieved)
                }
                FusumaView(size: geometry.size, transit: $fusumaTransit, refresh: {
                    presentation = moveTo
                })
            }
            .onAppear() {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "music", withExtension: "mp3")!)
                    audioPlayer!.volume = 0.3
                    audioPlayer!.numberOfLoops = -1
                    audioPlayer!.play()
                } catch {
                    print(error)
                }
            }
            .onChange(of: moveTo) { newValue in
                fusumaTransit = true
            }
            .statusBar(hidden: true)
        }
        .ignoresSafeArea()
    }
}

enum Presentation {
    case main,play,description,trick
}
