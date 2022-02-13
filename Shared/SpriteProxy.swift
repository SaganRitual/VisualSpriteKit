// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SpriteKit
import SwiftUI

class SpriteProxy: ObservableObject {
    @Published var offset: CGPoint
    @Published var position: CGPoint
    @Published var rotation: Angle
    @Published var scale: Double

    private var sprite: SKSpriteNode!

    private var oo: AnyCancellable!
    private var p: AnyCancellable!
    private var r: AnyCancellable!
    private var s: AnyCancellable!

    init(_ oo: CGPoint, _ p: CGPoint, _ r: Angle, _ s: Double) {
        offset = oo
        position = p
        rotation = r
        scale = s
    }

    func postInit(_ sprite: SKSpriteNode) {
        self.sprite = sprite

        oo = $offset.sink { [weak self, weak sprite] in
            guard let myself = self else { return }
            guard let mySprite = sprite else { return }
            guard let myScene = (mySprite.parent?.scene as? GameScene) else { return }

            mySprite.position = myScene.toScene($0 + myself.position)
        }

        p = $position.sink { [weak self, weak sprite] in
            guard let myself = self else { return }
            guard let mySprite = sprite else { return }
            guard let myScene = (mySprite.parent?.scene as? GameScene) else { return }

            mySprite.position = myScene.toScene($0 + myself.offset)
        }

        r = $rotation.sink { [weak sprite] in sprite?.zRotation = $0.radians }
        s = $scale.sink { [weak sprite] in sprite?.scale = $0 }
    }
}
