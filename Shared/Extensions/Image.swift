// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

extension Image {
    func kenneyStyle() -> some View {
        self
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(width: 64)
    }
}
