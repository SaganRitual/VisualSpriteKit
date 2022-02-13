// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

extension Double {
    func show(_ decimals: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals
        formatter.usesGroupingSeparator = false

        return "\(formatter.string(from: NSNumber(value: self))!)"
    }
}
