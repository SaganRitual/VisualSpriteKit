// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteMenu: View {
    @Binding var proxyState: SpriteProxyView.ProxyState

    var body: some View {
        Menu(
            content: {
                Section {
                    Button(
                        action: { proxyState = .move },
                        label: {
                            Label("Move", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                        }
                    )

                    Button(
                        action: { proxyState = .rotate },
                        label: {
                            Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
                        }
                    )

                    Button(
                        action: { proxyState = .scale },
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

                    Button(
                        action: {},
                        label: {
                            Label("Sprites", systemImage: "square.on.circle")
                        }
                    )
                }
            },
            label: {
                Circle()
                    .fill(.blue)
                    .frame(width: 32, height: 32)
            }
        )
    }
}

struct SpriteMenu_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { gp in
            SpriteMenu(
                proxyState: .constant(.menu)
            )
            .preferredColorScheme(.dark)
        }
    }
}
