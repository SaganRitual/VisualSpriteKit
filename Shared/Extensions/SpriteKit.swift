// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

extension SKSpriteNode {
    var scale: Double {
        get { getScale() }
        set { setScale(newValue) }
    }

    func getScale() -> Double { (userData?["scale"] as? Double) ?? 1.0 }

    override open func setScale(_ scale: CGFloat) {
        if userData == nil { userData = [:] }
        userData!["scale"] = scale

        super.setScale(scale)
    }
}
