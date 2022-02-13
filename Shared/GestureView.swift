// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI
import UIKit

struct GestureView: View {
    @EnvironmentObject var gameScene: GameScene

    @State private var diagnosticText = "Nothing detected"
    @State private var spriteProxies = [SpriteProxyView]()

    let size: CGSize

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .onGesture(
                    onPan: { sender in
                        let position = sender.location(in: sender.view)
                        diagnosticText = "Pan at \(position.show(3))"
                    },
                    onPinch: { sender in
                        let position = sender.location(in: sender.view)
                        diagnosticText = "Pinch at \(position.show(3))"
                    },
                    onTap: { sender in
                        let position = sender.location(in: sender.view)
                        diagnosticText = "Tapped at \(position.show(3))"

                        let proxy = SpriteProxy(position: position)
                        proxy.postInit(gameScene.addSprite(at: position))
                        spriteProxies.append(SpriteProxyView(proxy: proxy))
                    }
                )

//            Text(diagnosticText)
//                .foregroundColor(.yellow)
//                .font(.title)

            ForEach(spriteProxies) {
                $0
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

struct Previews_GestureView_Previews: PreviewProvider {
    static var previews: some View {
        GestureView(size: AppDefinitions.gameSceneSize)
            .preferredColorScheme(.dark)
    }
}

// 🙏 https://www.codementor.io/@pteasima
extension View {
    func onGesture(
        onPan: @escaping (UIPanGestureRecognizer) -> Void = { _ in },
        onPinch: @escaping (UIPinchGestureRecognizer) -> Void = { _ in },
        onRotate: @escaping (UIRotationGestureRecognizer) -> Void = { _ in },
        onTap: @escaping (UITapGestureRecognizer) -> Void = { _ in }
    ) -> some View {
        self.overlay(
            GestureHandler(
                onPan: onPan,
                onPinch: onPinch,
                onRotate: onRotate,
                onTap: onTap
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
    }
}

fileprivate struct GestureHandler: UIViewRepresentable {
    var onPan: (UIPanGestureRecognizer) -> Void
    var onPinch: (UIPinchGestureRecognizer) -> Void
    var onRotate: (UIRotationGestureRecognizer) -> Void
    var onTap: (UITapGestureRecognizer) -> Void

    final class Coordinator: NSObject {
        var base: GestureHandler
        init(base: GestureHandler) {
            self.base = base
        }

        @objc func onPan(sender: UIPanGestureRecognizer) { base.onPan(sender) }
        @objc func onPinch(sender: UIPinchGestureRecognizer) { base.onPinch(sender) }
        @objc func onRotate(sender: UIRotationGestureRecognizer) { base.onRotate(sender) }
        @objc func onTap(sender: UITapGestureRecognizer) { base.onTap(sender) }
    }

    func makeCoordinator() -> Coordinator {
        .init(base: self)
    }

    func makeUIView(context: Context) -> GestureHandlingView {
        .init(coordinator: context.coordinator)
    }

    func updateUIView(_ view: GestureHandlingView, context: Context) {
        context.coordinator.base = self
    }

    final class GestureHandlingView: UIView {
        init(coordinator: GestureHandler.Coordinator) {
            super.init(frame: .zero)

            let panRec = UIPanGestureRecognizer(target: coordinator, action: #selector(GestureHandler.Coordinator.onPan(sender:)))
            addGestureRecognizer(panRec)

            let pinchRec = UIPinchGestureRecognizer(target: coordinator, action: #selector(GestureHandler.Coordinator.onPinch(sender:)))
            addGestureRecognizer(pinchRec)

            let rotateRec = UIRotationGestureRecognizer(target: coordinator, action: #selector(GestureHandler.Coordinator.onRotate(sender:)))
            addGestureRecognizer(rotateRec)

            let tapRec = UITapGestureRecognizer(target: coordinator, action: #selector(GestureHandler.Coordinator.onTap(sender:)))
            addGestureRecognizer(tapRec)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
