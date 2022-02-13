// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum ArenaSize: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let nv = nextValue()
        value.width += nv.width
        value.height += nv.height
    }
}

struct ContentView: View {
    @State private var arenaSize = CGSize.zero

    var body: some View {
        ZStack {
            GameView()
                .background(
                    GeometryReader { Color.clear.preference(key: ArenaSize.self, value: $0.size) }
                        .onPreferenceChange(ArenaSize.self) { arenaSize = $0 }
                )

            GestureView(size: arenaSize)
                .background(.clear)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
