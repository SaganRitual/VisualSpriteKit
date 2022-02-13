// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI
import UIKit

struct GameView: View {
    @EnvironmentObject var gameScene: GameScene

    @State private var gameViewSize = CGSize.zero

    #if DEBUG
    let debugOptions: SpriteView.DebugOptions = [.showsFPS, .showsNodeCount]
    #else
    let debugOptions: SpriteView.DebugOptions = []
    #endif

    var body: some View {
        SpriteView(
            scene: gameScene,
            options: [.ignoresSiblingOrder, .shouldCullNonVisibleNodes],
            debugOptions: debugOptions
        )
        .aspectRatio(1.0, contentMode: .fit)
        .background(
            GeometryReader { Color.purple.preference(key: ArenaSize.self, value: $0.size) }
                .onPreferenceChange(ArenaSize.self) {
                    gameViewSize = $0
                    gameScene.viewSize = $0
                }
        )
    }
}
