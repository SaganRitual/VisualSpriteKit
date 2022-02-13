// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

extension Angle {
    func show(_ decimals: Int) -> String {
        self.radians.show(decimals)
    }
}
