// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum SelectorViewSize: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct SelectorHandle: View {
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 32, height: 32)
    }
}

struct SelectorView: View {
    @State private var selectorViewSize = CGSize.zero

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.blue, lineWidth: 2)
                .background(
                    GeometryReader { Color.clear.preference(key: SelectorViewSize.self, value: $0.size) }
                        .onPreferenceChange(SelectorViewSize.self) {
                            let side = min($0.width, $0.height)
                            selectorViewSize = CGSize(width: side, height: side)
                        }
                )

            Rectangle()
                .fill(.blue)
                .frame(width: 2, height: selectorViewSize.height)

            Rectangle()
                .fill(.blue)
                .frame(width: selectorViewSize.width, height: 2)

            Button(
                action: {},
                label: { SelectorHandle() }
            )
            .offset(y: -selectorViewSize.height / 2)
        }
    }
}

struct SelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView()
            .preferredColorScheme(.dark)
    }
}
