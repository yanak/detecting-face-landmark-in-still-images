//
//  UserData.swift
//  DetectingFaceLandmarkInStillImages
//
//  Created by 田中 穏識 on 2020/04/03.
//  Copyright © 2020 田中 穏識. All rights reserved.
//

import SwiftUI

final class UserData: ObservableObject {
    // var facialImages = FacialImage()
    var featureImage: NSImage? {
        // var img = NSImage(byReferencingFile: "spe")
        let nsImage = NSImage(byReferencingFile: "/Users/s04118/Documents/oji.jpg")
        return nsImage
    }
}
