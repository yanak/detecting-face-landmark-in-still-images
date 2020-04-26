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
    // @EnvironmentObject private var userData: UserData
    var image: NSImage?
    // var boundingBox: CGRect?
    var landmarks: Landmark
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    
    var body: some View {
        ZStack {
            Image(nsImage: image ?? NSImage()).frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            GeometryReader { geometry in
                Path { path in
                    // var width: CGFloat = 100.0
                    // let height: CGFloat = 150.0
                    
                    //path.move(to: CGPoint(x: width , y: height ))
                    // 0.21646055579185486, 0.24292534589767456, 0.5806270241737366, 0.42152664065361023
                    //path.addLine(to: .init(x: width + 100, y: height))
                    //path.addLine(to: .init(x: width + 100, y: height + 100))
                    //path.addLine(to: .init(x: width + 0, y: height + 100))
                    //path.addLine(to: .init(x: width + 100, y: height + 0))
                    //                let points = VNImagePointForFaceLandmarkPoint(0.21646055579185486, 0.24292534589767456, 0.5806270241737366, 0.42152664065361023)
                    
                    //path.addRect(VNImageRectForNormalizedRect(self.boundingBox ?? CGRect(), Int(geometry.size.width), Int(geometry.size.height)))
                    
                    //                HexagonParameters.points.forEach {
                    //                    path.addLine(
                    //                        to: .init(
                    //                            x: width * $0.useWidth.0 * $0.xFactors.0,
                    //                            y: height * $0.useHeight.0 * $0.yFactors.0
                    //                        )
                    //                    )
                    //                }
                    
                    
                    // if let nosePoints = self.landmarks.nose?.pointsInImage(imageSize: geometry.size) {
                    if let nosePoints = self.landmarks.landmark!.nose {
                        //                        let initialPoint = VNImagePointForFaceLandmarkPoint(simd_make_float2(Float(nosePoints.normalizedPoints.first!.x), Float(nosePoints.normalizedPoints.first!.y)), self.boundingBox!, Int(geometry.size.width), Int(geometry.size.height))
                        //
                        //                        //path.move(to: .init(x: nosePoints.first!.applying(<#T##t: CGAffineTransform##CGAffineTransform#>)., y: 100.0))
                        //                        path.move(to: nosePoints.first!)
                        //                        path.move(to: initialPoint)
                        //                        nosePoints.normalizedPoints.forEach { (point) in
                        //                            let convertedPoint = VNImagePointForFaceLandmarkPoint(simd_make_float2(Float(nosePoints.normalizedPoints.first!.x), Float(nosePoints.normalizedPoints.first!.y)), self.boundingBox!, Int(geometry.size.width), Int(geometry.size.height))
                        //                            path.addLine(to: convertedPoint)
                        //                        }
                        
                        let box = boundingBox(forRegionOfInterest: self.landmarks.boundingBox, withinImageBounds: CGRect(x: 0, y: 0, width: self.image!.size.width, height: self.image!.size.height))
                        
                        //let affin = CGAffineTransform(scaleX: box.size.width, y: box.size.height).scaledBy(x: 1000, y: 1500)
                        let affin = CGAffineTransform(scaleX: 1200, y: 1800)

                        let pointCount = nosePoints.pointCount
                        if pointCount > 1 {
                            let points = nosePoints.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
                            //let points = nosePoints.normalizedPoints
                            //path.move(to: points[1])
                            path.addLines(points)
                            //path.addLines(nosePoints.normalizedPoints)
                            //path.addPath(path.transform(affin).shape)
                        }
                        path.closeSubpath()
                        

                    }
                    if let leftEye = self.landmarks.landmark!.leftEye {
                        let leftEyePoint = leftEye.pointsInImage(imageSize: CGSize(width: self.image!.size.width, height: self.image!.size.height))
                        //path.move(to: leftEye[1])
                        path.addLines(leftEye)
                    }
                    
                    
                }
                    //.fill(Color.black)
                    //.transform(affineTransform)

                    //.applying(CGAffineTransform(translationX: self.landmarks.boundingBox.origin.x, y: self.landmarks.boundingBox.origin.y).scaledBy(x: self.landmarks.boundingBox.size.width * 1000, y: self.landmarks.boundingBox.size.height * 1000))
                    //.applying(CGAffineTransform(scaleX: 1200, y: 1800))
                    .stroke(Self.symbolColor, lineWidth: 5.0)
                
                
                //                (CGAffineTransform(translationX: self.landmarks.boundingBox.size.width, y: self.landmarks.boundingBox.size.height).scaledBy(x: 1000, y: 1000)
                
                //                Path { path in
                //                    if let nosePoints = self.landmarks.nose?.pointsInImage(imageSize: geometry.size) {
                //                        nosePoints.forEach { (point) in
                //                            path.addLine(to: point)
                //                        }
                //                    }
                //                }
                //                .stroke(Self.symbolColor, lineWidth: 10.0)
            }
            
        }
        // let url = URL(fileReferenceLiteralResourceName: "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg")
        //let image = NSImage(contentsOfFile: "/Users/s04118/yasu.jpg")
        //print("image size \(nsImage!.size.width):\(nsImage!.size.height)")
        
        //let nsImage = NSImage(byReferencing: "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg")
        //        return Image(nsImage: nsImage ?? NSImage())
        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        FaceImage()
        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
        // return Image(nsImage: image ?? NSImage())
        //    .frame(maxWidth: .infinity, maxHeight: .infinity)
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

//func scaleAndOrient(image: NSImage) -> NSImage {
//
//    // Set a default value for limiting image size.
//    let maxResolution: CGFloat = 640
//
//    let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
//
//    // Compute parameters for transform.
//    let width = CGFloat(cgImage.width)
//    let height = CGFloat(cgImage.height)
//    var transform = CGAffineTransform.identity
//
//    var bounds = CGRect(x: 0, y: 0, width: width, height: height)
//
//    if width > maxResolution ||
//        height > maxResolution {
//        let ratio = width / height
//        if width > height {
//            bounds.size.width = maxResolution
//            bounds.size.height = round(maxResolution / ratio)
//        } else {
//            bounds.size.width = round(maxResolution * ratio)
//            bounds.size.height = maxResolution
//        }
//    }
//
//    let scaleRatio = bounds.size.width / width
//
//
//    return NSGraphicsImageRenderer(size: bounds.size).image { rendererContext in
//        let context = rendererContext.cgContext
//
//        if orientation == .right || orientation == .left {
//            context.scaleBy(x: -scaleRatio, y: scaleRatio)
//            context.translateBy(x: -height, y: 0)
//        } else {
//            context.scaleBy(x: scaleRatio, y: -scaleRatio)
//            context.translateBy(x: 0, y: -height)
//        }
//        context.concatenate(transform)
//        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
//    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let landmark = Landmark()
        let res = landmark.detect(filename: "/Users/s04118/Documents/yasu.jpg")
        
        
        
        
        
        let boundingBox = landmark.boundingBox
        let a = UserData().featureImage
        
        
        //            drawingLayer.bounds = CGRect(x: xLayer, y: yLayer, width: imageWidth, height: imageHeight)
        
        //        let faceBounds = boundingBox(forRegionOfInterest: boundingBox, withinImageBounds: bounds)
        
        return ContentView(image: a, landmarks: landmark)
        // ContentView()
    }
}

//struct Images {
//    var images: FacialImage
//}
