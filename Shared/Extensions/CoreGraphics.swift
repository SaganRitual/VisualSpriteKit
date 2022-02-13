// We are a way for the cosmos to know itself. -- C. Sagan

import CoreGraphics
import Foundation

extension CGFloat {
    func show(_ decimals: Int) -> String { Double(self).show(decimals) }
}

extension CGPoint {
    func asSize() -> CGSize { CGSize(width: x, height: y) }

    func show(_ decimals: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals
        formatter.usesGroupingSeparator = false

        return "(\(Double(x).show(decimals)), \(Double(y).show(decimals)))"
    }

    func yFlip() -> CGPoint { CGPoint(x: x, y: y * -1) }

    static func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func += (_ lhs: inout CGPoint, _ rhs: CGPoint) {
        lhs = lhs + rhs
    }

    static func + (_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }

    static func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func - (_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
    }

    static func * (_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
    }

    static func * (_ lhs: CGPoint, _ rhs: Double) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    static func / (_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x / rhs.width, y: lhs.y / rhs.height)
    }

    static func / (_ lhs: CGPoint, _ rhs: Double) -> CGPoint {
        CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

extension CGRect {
    func scaled(to scale: Double) -> CGRect {
        CGRect(origin: origin, size: size * scale)
    }
}

extension CGSize {
    func asPoint() -> CGPoint { CGPoint(x: width, y: height) }

    static func - (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    static func * (_ lhs: CGSize, _ rhs: Double) -> CGSize {
        CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    static func / (_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
    }

    static func / (_ lhs: CGSize, _ rhs: Double) -> CGSize {
        CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
}
