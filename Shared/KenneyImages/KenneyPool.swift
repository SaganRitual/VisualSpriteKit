// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

class KenneyCharacter: Identifiable {
    let firstTextureName: String
    let folder: String
    let images: [Image]
    let textures: [SKTexture]

    var id: String { folder }

    init(_ prototype: KenneyJson.Prototype) {
        folder = prototype.folderName

        let start = prototype.firstIndex
        let end = start + prototype.count
        var firstTextureName: String?
        var images = [Image]()
        var textures = [SKTexture]()
        for ix in start..<end {
            let filename = String(format: "character_%04d", ix)

            if firstTextureName == nil { firstTextureName = filename }

            let uiImage = UIImage(named: filename)!
            images.append(Image(uiImage: uiImage))
            textures.append(SKTexture(image: uiImage))
        }

        self.images = images
        self.firstTextureName = firstTextureName!
        self.textures = textures
    }

    func animate(_ sprite: SKSpriteNode) {
        guard textures.count > 1 else { return }

        sprite.run(SKAction.repeatForever(
            SKAction.animate(with: textures, timePerFrame: 1.0 / Double(textures.count))
        ))
    }

    func makeSprite() -> SKSpriteNode {
        SKSpriteNode(texture: textures.first!)
    }
}

class KenneyPool {
    let characters: [KenneyCharacter]
    let prototypes = KenneyJson.decode()

    init() {
        characters = prototypes.map { .init($0) }
    }
}
