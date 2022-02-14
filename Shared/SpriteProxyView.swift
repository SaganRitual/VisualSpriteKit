// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SwiftUI
import SpriteKit

struct SpriteProxyView: View, Identifiable {
    var id: UUID { proxy.id }

    @State private var rotationAnchor = Angle.zero

    @ObservedObject var proxy: SpriteProxy

    var body: some View {
        Group {
            switch proxy.proxyState {
            case .menu:
                SpriteMenu(spriteID: id, proxy: proxy)
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
                    onTap: { _ in proxy.proxyState = .menu }
                )
            case .rotate:
                SelectorView(
                    mode: .rotate, rotation: proxy.rotation, size: CGSize(width: 300, height: 300)
                )
                .onGesture(
                    onPan: { sender in
                        let s = sender.location(in: sender.view)
                        let t = (s - CGPoint(x: 150, y: 150)).yFlip().applying(CGAffineTransform(rotationAngle: -(proxy.rotation + proxy.rotationOffset).radians))
                        let a = -atan2(t.y, t.x)

                        if sender.state == .began {
                            rotationAnchor = -Angle.radians(a)
                        } else {
                            proxy.rotationOffset = rotationAnchor + Angle.radians(a)
                        }

                        if sender.state == .ended {
                            proxy.rotation += proxy.rotationOffset
                            proxy.rotationOffset = .zero
                        }
                    },
                    onTap: { _ in proxy.proxyState = .menu }
                )
                .rotationEffect(proxy.rotation + proxy.rotationOffset)

            case .scale:
                SelectorView(
                    mode: .scale, rotation: proxy.rotation, size: CGSize(width: 200, height: 200) * proxy.scale
                )
                .onGesture(
                    onPinch: { sender in
                        proxy.scale *= sender.scale
                        sender.scale = 1.0
                    },
                    onTap: { _ in proxy.proxyState = .menu }
                )
            }
        }
        .offset(proxy.offset.asSize())
        .position(proxy.position)
    }
}
