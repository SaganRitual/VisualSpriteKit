// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

@main
struct LorentzApp: App {
//    @StateObject var gameScene: GameScene
//
//    init() {
//        let size = CGSize(width: AppDefinitions.gameSceneSide, height: AppDefinitions.gameSceneSide)
//        let gs = GameScene(size: size)
//        _gameScene = StateObject(wrappedValue: gs)
//    }

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environmentObject(gameScene)
        }
    }
}
