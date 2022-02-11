// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI
import UIKit

enum GameViewSize: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

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
            GeometryReader { Color.clear.preference(key: GameViewSize.self, value: $0.size) }
                .onPreferenceChange(GameViewSize.self) { gameViewSize = $0 }
        )
        .onGesture(
            onPan: {
                if $0.state == .began {
                    let start = $0.location(in: nil)
                    print("start", start)
                }

                let translation = $0.translation(in: nil)
                print("translation", translation)
            },
            onPinch: {
                print("pinched")
            },
            onTap: {
                let spritePosition = ($0 - gameViewSize / 2).yFlip() / gameViewSize
                gameScene.tap(at: spritePosition)
            }
        )
    }
}
