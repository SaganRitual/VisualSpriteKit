// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteProxy: View, Identifiable {
    let id = UUID()

    enum ProxyState {
        case menu, move
    }

    @State private var offset = CGPoint.zero
    @State private var position: CGPoint
    @State private var proxyState = ProxyState.menu

    init(position: CGPoint) {
        _position = State(initialValue: position)
    }

    var body: some View {
        Group {
            switch proxyState {
            case .menu:
                SpriteMenu(proxyState: $proxyState)
            case .move:
                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                    .font(.largeTitle)
                    .onGesture(
                        onPan: { sender in
                            if sender.state == .began || sender.state == .changed {
                                offset = sender.translation(in: sender.view)
                                print("dragging \(offset)")
                            } else if sender.state == .ended {
                                print("end drag")
                                offset = sender.translation(in: sender.view)
                                position += offset
                                offset = .zero
                                proxyState = .menu
                            }
                        }
                    )
            }
        }
        .offset(offset.asSize())
        .position(position)
    }
}

struct SpriteProxy_Previews: PreviewProvider {
    static var previews: some View {
        SpriteProxy(position: .zero)
    }
}
