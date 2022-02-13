// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SpriteKit
import SwiftUI

class SpriteProxy: ObservableObject {
    @Published var position: CGPoint
    @Published var rotation: Angle
    @Published var scale: Double

    private var sprite: SKSpriteNode!

    private var p: AnyCancellable!
    private var r: AnyCancellable!
    private var s: AnyCancellable!

    init(_ p: CGPoint, _ r: Angle, _ s: Double) {
        position = p
        rotation = r
        scale = s
    }

    func postInit(_ sprite: SKSpriteNode) {
        self.sprite = sprite

        p = $position.sink { sprite.position = $0 }
        r = $rotation.sink { sprite.zRotation = $0.radians }
        s = $scale.sink { sprite.scale = $0 }
    }
}
