//
//  ContentView.swift
//  DetectingFaceLandmarkInStillImages
//
//  Created by 田中 穏識 on 2020/03/30.
//  Copyright © 2020 田中 穏識. All rights reserved.
//

import SwiftUI
import Vision

struct ContentView: View {
    var image: NSImage?
    var landmarks: Landmark
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    
    var body: some View {
        ZStack {
            Image(nsImage: image ?? NSImage()).frame(maxWidth: .infinity, maxHeight: .infinity)
            
            GeometryReader { geometry in
                Path { path in
                    
//                    if let nosePoints = self.landmarks.landmark!.nose {
//
////                        let box = boundingBox(forRegionOfInterest: self.landmarks.boundingBox, withinImageBounds: CGRect(x: 0, y: 0, width: self.image!.size.width, height: self.image!.size.height))
////
////                        let affin = CGAffineTransform(scaleX: 1200, y: 1800)
//
//                        let pointCount = nosePoints.pointCount
//                        if pointCount > 1 {
//                            let points = nosePoints.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
//                            //let points = nosePoints.normalizedPoints
//                            //path.move(to: points[1])
//                            path.addLines(points)
//                            //path.addLines(nosePoints.normalizedPoints)
//                            //path.addPath(path.transform(affin).shape)
//                        }
//                        path.closeSubpath()
//                    }
//                    if let leftEye = self.landmarks.landmark!.leftEye {
//                        let leftEyePoint = leftEye.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
//                        //path.move(to: leftEye[1])
//                        path.addLines(leftEyePoint)
//                        path.closeSubpath()
//                    }
//
//                    if let leftEye = self.landmarks.landmark!.outerLips {
//                        let leftEyePoint = leftEye.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
//                        //path.move(to: leftEye[1])
//                        path.addLines(leftEyePoint)
//                        path.closeSubpath()
//                    }
                    
                    let landmarkRegions = [
                        self.landmarks.landmark!.nose,
                        self.landmarks.landmark!.outerLips,
                        self.landmarks.landmark!.leftEye,
//                        self.landmarks.landmark!.leftPupil,
                        self.landmarks.landmark!.rightEye,
//                        self.landmarks.landmark!.rightPupil,
                        self.landmarks.landmark!.innerLips,

                    ]
                    for region in landmarkRegions {
                        let points = region!.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
                        path.addLines(points)
                        path.closeSubpath()
                    }
                    
                    let openLandmarkRegions = [
                        self.landmarks.landmark!.noseCrest,
                        self.landmarks.landmark!.faceContour,
                        // self.landmarks.landmark!.medianLine,
                        self.landmarks.landmark!.leftEyebrow,
                        self.landmarks.landmark!.rightEyebrow,
                    ]
                    for region in openLandmarkRegions {
                        let points = region!.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
                        path.addLines(points)
                    }
                    
                    
                }
                .stroke(Self.symbolColor, lineWidth: 3.0)
            }
        }
    }
}

fileprivate func boundingBox(forRegionOfInterest: CGRect, withinImageBounds bounds: CGRect) -> CGRect {
    
    let imageWidth = bounds.width
    let imageHeight = bounds.height
    
    // Begin with input rect.
    var rect = forRegionOfInterest
    
    // Reposition origin.
    rect.origin.x *= imageWidth
    rect.origin.x += bounds.origin.x
    rect.origin.y = (1 - rect.origin.y) * imageHeight + bounds.origin.y
    
    // Rescale normalized coordinates.
    rect.size.width *= imageWidth
    rect.size.height *= imageHeight
    
    return rect
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let landmark = Landmark()
        let res = landmark.detect(filename: "/Users/s04118/Documents/oji.jpg")
        let boundingBox = landmark.boundingBox
        let a = UserData().featureImage
        return ContentView(image: a, landmarks: landmark)
    }
}
