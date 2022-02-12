// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteProxy: View, Identifiable {
    let id = UUID()

    enum ProxyState {
        case menu, move, rotate, scale
    }

    @State private var offset = CGPoint.zero
    @State private var position: CGPoint
    @State private var proxyState = ProxyState.menu
    @State private var rotation = Angle.zero
    @State private var rotationAnchor = Angle.zero
    @State private var rotationOffset = Angle.zero
    @State private var scale = 1.0

    init(position: CGPoint) {
        _position = State(initialValue: position)
    }

    var body: some View {
        Group {
            switch proxyState {
            case .menu:
                SpriteMenu(proxyState: $proxyState)
            case .move:
                SelectorView(
                    mode: .move, rotation: rotation, size: CGSize(width: 100, height: 100)
                )
                .onGesture(
                    onPan: { sender in
                        offset = sender.translation(in: sender.view)

                        if sender.state == .ended {
                            position += offset
                            offset = .zero
                        }
                    },
                    onTap: { _ in proxyState = .menu }
                )
            case .rotate:
                SelectorView(
                    mode: .rotate, rotation: rotation, size: CGSize(width: 300, height: 300)
                )
                .onGesture(
                    onPan: { sender in
                        let t = sender.location(in: nil) - position

                        if sender.state == .began {
                            rotationAnchor = -.radians(atan2(t.y, t.x))
                        } else {
                            rotationOffset = rotationAnchor + .radians(atan2(t.y, t.x))
                        }

                        if sender.state == .ended {
                            rotation += rotationOffset
                            rotationOffset = .zero
                        }
                    },
                    onTap: { _ in proxyState = .menu }
                )
                .rotationEffect(rotation + rotationOffset)

            case .scale:
                SelectorView(
                    mode: .scale, rotation: rotation, size: CGSize(width: 100, height: 100) * scale
                )
                .onGesture(
                    onPinch: { sender in
                        scale = sender.scale
                    },
                    onTap: { _ in proxyState = .menu }
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
