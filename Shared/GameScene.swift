// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SpriteKit
import SwiftUI

class GameScene: SKScene, ObservableObject {
    let backgroundSprite = SpritePool.lines.makeSprite()
    var viewSize: CGSize!

    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameScene {
    func addSprite(at position: CGPoint) -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "character_0001")
        let sprite = SKSpriteNode(texture: texture)

        let action = SKAction.run { [weak self, sprite] in
            guard let myself = self else { return }

            sprite.zPosition = 1
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            sprite.scale = 1.0
            sprite.size = CGSize(width: 128, height: 128)
            sprite.position = (position - (myself.viewSize / 2)).yFlip() * (myself.size / myself.viewSize)
            myself.backgroundSprite.addChild(sprite)
        }

        backgroundSprite.run(action)
        return sprite
    }
}

extension GameScene {
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        backgroundSprite.anchorPoint = anchorPoint
        backgroundSprite.size = self.size
        backgroundSprite.color = .clear

        self.addChild(backgroundSprite)
    }
}
