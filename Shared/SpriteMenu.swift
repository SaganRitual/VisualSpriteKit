// We are a way for the cosmos to know itself. -- C. Sagan

import UIKit
import SwiftUI

struct SpriteMenu: View {
    @EnvironmentObject var gameScene: GameScene
    let spriteID: UUID
    @ObservedObject var proxy: SpriteProxy

    var body: some View {
        Menu(
            content: {
                Section {
                    Button(
                        action: { proxy.proxyState = .move },
                        label: {
                            Label("Move", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                        }
                    )

                    Button(
                        action: { proxy.proxyState = .rotate },
                        label: {
                            Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
                        }
                    )

                    Button(
                        action: { proxy.proxyState = .scale },
                        label: {
                            Label(
                                "Scale",
                                systemImage: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left"
                            )
                        }
                    )
                }

                Section {
                    Button(
                        action: {},
                        label: {
                            Label("Actions", systemImage: "figure.walk")
                        }
                    )

                    Button(
                        action: {},
                        label: {
                            Label("Physics", systemImage: "bolt")
                        }
                    )

                    Menu(
                        content: {
                            ForEach(gameScene.kenneyPool.characters) { kenneyCharacter in
                                Button(
                                    action: {
                                        gameScene.changeSpriteImage(id: spriteID, to: kenneyCharacter)
                                    },
                                    label: {
                                        HStack {
                                            Text(kenneyCharacter.folder)
                                            kenneyCharacter.images.first!
                                        }
                                    }
                                )
                            }
                        },
                        label: {
                            Label("Sprites", systemImage: "square.on.circle")
                        }
                    )
                }
            },
            label: {
                Circle()
                    .strokeBorder(.blue, lineWidth: 2)
                .frame(width: 64, height: 64)
            }
        )
    }
}
