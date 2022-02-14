// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SpriteKit
import SwiftUI

class SpriteProxy: ObservableObject {
    let id = UUID()

    @Published var offset: CGPoint
    @Published var position: CGPoint
    @Published var rotation: Angle
    @Published var rotationOffset = Angle.zero
    @Published var scale: Double

    enum ProxyState {
        case menu, move, rotate, scale
    }

    @Published var proxyState = ProxyState.menu

    private var sprite: SKSpriteNode!

    private var oOffset: AnyCancellable!
    private var oPosition: AnyCancellable!
    private var oRotation: AnyCancellable!
    private var oRotationOffset: AnyCancellable!
    private var oScale: AnyCancellable!

    init(
        offset: CGPoint = .zero, position: CGPoint = .zero,
        rotation: Angle = .zero, rotationOffset: Angle = .zero,
        scale: Double = 1.0
    ) {
        self.offset = offset
        self.position = position
        self.rotation = rotation
        self.rotationOffset = rotationOffset
        self.scale = scale
    }

    func postInit(_ sprite: SKSpriteNode) {
        sprite.id = id

        self.sprite = sprite

        oOffset = $offset.sink { [weak self, weak sprite] in
            guard let myself = self else { return }
            guard let mySprite = sprite else { return }
            guard let myScene = (mySprite.parent?.scene as? GameScene) else { return }

            mySprite.position = myScene.toScene($0 + myself.position)
        }

        oPosition = $position.sink { [weak self, weak sprite] in
            guard let myself = self else { return }
            guard let mySprite = sprite else { return }
            guard let myScene = (mySprite.parent?.scene as? GameScene) else { return }

            mySprite.position = myScene.toScene($0 + myself.offset)
        }

        oRotation = $rotation.sink { [weak self, weak sprite] in
            guard let myself = self else { return }
            guard let mySprite = sprite else { return }
            
            mySprite.zRotation = -($0 + myself.rotationOffset).radians
        }

        oRotationOffset = $rotationOffset.sink { [weak self, weak sprite] in
            guard let myself = self else { return }
            guard let mySprite = sprite else { return }

            mySprite.zRotation = -($0 + myself.rotation).radians
        }

        oScale = $scale.sink { [weak sprite] in sprite?.scale = $0 }
    }
}
