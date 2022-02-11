// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpriteProxy: View, Identifiable {
    let id = UUID()
    let position: CGPoint

    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 32, height: 32)
            .position(position)
    }
}

struct SpriteProxy_Previews: PreviewProvider {
    static var previews: some View {
        SpriteProxy(position: .zero)
    }
}
