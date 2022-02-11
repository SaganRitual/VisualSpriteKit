// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import SpriteKit
import SwiftUI

class GameScene: SKScene, ObservableObject {
    let tapPublisher = CurrentValueSubject<CGPoint, Never>(CGPoint.zero)

    var belleA: Belle!
    var belleB: Belle!
    var belleC: Belle!

    let backgroundSprite = SpritePool.lines.makeSprite()
    var pendingContinuePan: CGPoint?
    var pendingStartPan: CGPoint?
    var pendingTap: CGPoint?
    weak var selectedSprite: SKSpriteNode?
    var selectionIndicator: SelectionIndicator!
    var sprites = [SKSpriteNode]()

    override init(size: CGSize) {
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameScene {
    func tap(at position: CGPoint) {
        guard pendingTap == nil else { return }
        pendingTap = position
    }

    func tapSprite(_ sprite: SKSpriteNode) {
        if sprite === selectedSprite {
            selectedSprite = nil
            selectionIndicator.deselect()
        } else {
            selectedSprite = sprite
            selectionIndicator.select(sprite)
        }
    }
}

extension GameScene {
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        scaleMode = .aspectFit
//        physicsWorld.gravity = CGVector(dx: 0, dy: -1.0)

        backgroundSprite.anchorPoint = anchorPoint
        backgroundSprite.size = self.size
        backgroundSprite.color = .clear
//        backgroundSprite.setScale(0.5)

        self.addChild(backgroundSprite)

//        belleA = Belle.makeBelle(color: .red, at: CGPoint(x: 0, y: 0), skParent: backgroundSprite, physicsBodySettings: physicsBodySettings)
//        belleB = Belle.makeBelle(color: .green, at: CGPoint(x: 100, y: 0), skParent: self, physicsBodySettings: physicsBodySettings)
//        belleC = Belle.makeBelle(color: .blue, at: CGPoint(x: 0, y: 100), skParent: self, physicsBodySettings: physicsBodySettings)

        selectionIndicator = SelectionIndicator(self)
    }

    override func update(_ currentTime: TimeInterval) {
        guard let p = pendingTap else { return }
        pendingTap = nil

        let position = p * self.size

        for sprite in sprites {
            if sprite.frame.contains(position) {
                tapSprite(sprite)
                return
            }
        }

        let texture = SKTexture(imageNamed: "character_0001")
        let sprite = SKSpriteNode(texture: texture)
        sprite.zPosition = 1
        sprite.size = CGSize(width: 128, height: 128)
        sprite.position = position
        print("p", position, self.size, sprite.position)
        sprites.append(sprite)
        backgroundSprite.addChild(sprite)
    }
}
