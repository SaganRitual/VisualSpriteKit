// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct BiclopsView: View {
    func fuckBundles() -> some View {
        var images = [UIImage]()

        let items = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "KenneyImages")
        for item in items {
            let fileName = URL(string: item)?.lastPathComponent ?? "character_0000.png"
            let image = UIImage(named: "KenneyImages/\(fileName)")!
            images.append(image)
        }

//        imageView.image = UIImage.animatedImage(with: images, duration: Double(5*items.count))

        return Image(uiImage: images.first!)
    }

    var body: some View {
//        fuckBundles()
        Image(uiImage: UIImage(named: "character_0002")!)
    }
}

struct BiclopsView_Previews: PreviewProvider {
    static var previews: some View {
        BiclopsView()
    }
}
