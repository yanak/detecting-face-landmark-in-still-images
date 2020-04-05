//
//  FaceImage.swift
//  DetectingFaceLandmarkInStillImages
//
//  Created by 田中 穏識 on 2020/04/03.
//  Copyright © 2020 田中 穏識. All rights reserved.
//

import SwiftUI

struct FaceImage: View {
    var image: NSImage?
    
    var body: some View {

//        guard let image = NSImage(byReferencingFile: "/Users/s04118/Documents/project/test_command_line_tool/yasu.jpg") else {
//            fatalError("Unable to load image")
//        }
//        Image(nsImage: image)
        // Image("/Users/s04118/Documents/project/test_command_line_tool/yasu.jpg")
        //Image(nsImage: image!)
        
        var nsImage = NSImage(byReferencingFile: "/Users/s04118/Desktop/yasu.jpg")
        return Image(nsImage: nsImage!)
    }
}

struct FaceImage_Previews: PreviewProvider {
    static var previews: some View {
        var img = UserData().featureImage
        return FaceImage(image: UserData().featureImage)
    }
}
