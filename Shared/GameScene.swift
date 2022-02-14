// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SpriteKit
import SwiftUI

class GameScene: SKScene, ObservableObject {
    let backgroundSprite = SpritePool.lines.makeSprite()
    let kenneyPool = KenneyPool()
    
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
        let character = kenneyPool.characters.first!
        let sprite = character.makeSprite()

        let action = SKAction.run { [weak self, weak character, weak sprite] in
            guard let myself = self, let myCharacter = character, let mySprite = sprite
                else { return }

            mySprite.zPosition = 1
            mySprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            mySprite.scale = 1.0
            mySprite.size = CGSize(width: 128, height: 128)
            mySprite.position = myself.toScene(position)
            myself.backgroundSprite.addChild(mySprite)
            myCharacter.animate(mySprite)
        }

        backgroundSprite.run(action)
        return sprite
    }

    func changeSpriteImage(id: UUID, to character: KenneyCharacter) {
        let sprite = backgroundSprite.children
            .compactMap({ $0 as? SKSpriteNode })
            .first(where: { $0.id == id })!

        character.animate(sprite)
    }

    func toScene(_ position: CGPoint) -> CGPoint {
        (position - (viewSize / 2)).yFlip() * (size / viewSize)
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
