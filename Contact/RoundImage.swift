//
//  RoundImage.swift
//  Contacts
//
//  Created by Adrian Tineo on 28.10.20.
//

import SwiftUI

struct RoundImage: View {
    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(Circle())
			.frame(width: 198.0, height: 198.0)
			.frame(maxWidth: .infinity)
			.padding(.vertical, 24.0)
    }
}

struct RoundImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundImage(image: TestData.contact.photo)
            .previewLayout(.sizeThatFits)
    }
}
