//
//  ContentView.swift
//  DetectingFaceLandmarkInStillImages
//
//  Created by 田中 穏識 on 2020/03/30.
//  Copyright © 2020 田中 穏識. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // @EnvironmentObject private var userData: UserData
    var image: NSImage?
    
    var body: some View {
        // let url = URL(fileReferenceLiteralResourceName: "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg")
        //let image = NSImage(contentsOfFile: "/Users/s04118/yasu.jpg")
        //print("image size \(nsImage!.size.width):\(nsImage!.size.height)")
        
        //let nsImage = NSImage(byReferencing: "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg")
//        return Image(nsImage: nsImage ?? NSImage())
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        FaceImage()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
        return Image(nsImage: image ?? NSImage())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let a = UserData().featureImage
        return ContentView(image: a)
        // ContentView()
    }
}

//struct Images {
//    var images: FacialImage
//}
