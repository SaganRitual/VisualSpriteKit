// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SwiftUI
import SpriteKit

struct SpriteProxyView: View, Identifiable {
    let id = UUID()

    enum ProxyState {
        case menu, move, rotate, scale
    }

    @State private var proxyState = ProxyState.menu
    @State private var rotationAnchor = Angle.zero
    @State private var rotationOffset = Angle.zero

    @ObservedObject var proxy: SpriteProxy

    var body: some View {
        Group {
            switch proxyState {
            case .menu:
                SpriteMenu(proxyState: $proxyState)
            case .move:
                SelectorView(
                    mode: .move, rotation: proxy.rotation, size: CGSize(width: 100, height: 100)
                )
                .onGesture(
                    onPan: { sender in
                        proxy.offset = sender.translation(in: sender.view)

                        if sender.state == .ended {
                            proxy.position += proxy.offset
                            proxy.offset = .zero
                        }
                    },
                    onTap: { _ in proxyState = .menu }
                )
            case .rotate:
                SelectorView(
                    mode: .rotate, rotation: proxy.rotation, size: CGSize(width: 300, height: 300)
                )
                .onGesture(
                    onPan: { sender in
                        let t = sender.location(in: nil) - proxy.position

                        if sender.state == .began {
                            rotationAnchor = -.radians(atan2(t.y, t.x))
                        } else {
                            rotationOffset = rotationAnchor + .radians(atan2(t.y, t.x))
                        }

                        if sender.state == .ended {
                            proxy.rotation += rotationOffset
                            rotationOffset = .zero
                        }
                    },
                    onTap: { _ in proxyState = .menu }
                )
                .rotationEffect(proxy.rotation + rotationOffset)

            case .scale:
                SelectorView(
                    mode: .scale, rotation: proxy.rotation, size: CGSize(width: 100, height: 100) * proxy.scale
                )
                .onGesture(
                    onPinch: { sender in
                        proxy.scale = sender.scale
                    },
                    onTap: { _ in proxyState = .menu }
                )
            }
        }
        .offset(proxy.offset.asSize())
        .position(proxy.position)
    }
}
