// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum SelectorViewSize: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct SelectorHandle: View {
    let color: Color

    init(color: Color = .blue) { self.color = color }

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 16, height: 16)
    }
}

struct SelectorView: View {
    enum Mode { case move, rotate, scale }

    let mode: Mode
    let rotation: Angle
    let size: CGSize

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.blue, lineWidth: 2)
                .frame(width: size.width, height: size.height)

            if mode == .move {
                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            } else {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 2, height: size.height)

                Rectangle()
                    .fill(.blue)
                    .frame(width: size.width, height: 2)
            }

            if mode == .rotate {
                SelectorHandle(color: .green)
                    .offset(y: -size.height / 2)

                SelectorHandle()
                    .offset(x: -size.width / 2)

                SelectorHandle()
                    .offset(y: size.height / 2)

                SelectorHandle()
                    .offset(x: size.width / 2)
            }
        }
    }
}

struct SelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(mode: .scale, rotation: .zero, size: CGSize(width: 100, height: 100))
            .preferredColorScheme(.dark)
    }
}
