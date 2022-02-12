// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteProxy: View, Identifiable {
    let id = UUID()
    let position: CGPoint

    var body: some View {
        Menu(
            content: {
                Section {
                    Button(
                        action: {},
                        label: {
                            Label("Move", systemImage: "arrow.up.and.down.and.arrow.left.and.right")
                        }
                    )

                    Button(
                        action: {},
                        label: {
                            Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
                        }
                    )

                    Button(
                        action: {},
                        label: {
                            Label("Scale", systemImage: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left")
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
        .position(position)
        .gesture(
            DragGesture()
                .onChanged {
                    print("onchanged \($0)")
                }
        )
    }
}

struct SpriteProxy_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { gp in
            SpriteProxy(position: CGPoint(x: gp.frame(in: .local).midX, y: gp.frame(in: .local).midY))
                .preferredColorScheme(.dark)
        }
    }
}
