// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit

extension SKSpriteNode {
    var id: UUID {
        get { getId() }
        set { setId(newValue) }
    }

    func getId() -> UUID { (userData?["id"] as? UUID)! }
    func hasId() -> Bool { (userData?["id"] as? UUID) != nil }

    func setId(_ id: UUID) {
        if userData == nil { userData = [:] }
        userData!["id"] = id
    }

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
