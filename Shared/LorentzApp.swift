// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

@main
struct LorentzApp: App {
    @StateObject var gameScene: GameScene

    init() {
        _gameScene = StateObject(wrappedValue: GameScene(size: AppDefinitions.gameSceneSize))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameScene)
        }
    }
}
