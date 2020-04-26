//
//  Landmark.swift
//  DetectingFaceLandmarkInStillImages
//
//  Created by 田中 穏識 on 2020/04/05.
//  Copyright © 2020 田中 穏識. All rights reserved.
//

import Foundation
import Vision
import AppKit

class Landmark: ObservableObject {
    var boundingBox: CGRect
    var landmark: VNFaceLandmarks2D?
    
    init() {
        boundingBox = CGRect()
    }
    
    /// - Tag: CreateRequests
    fileprivate func handleDetectedFaceLandmarks(request: VNRequest?, error: Error?) {
        if let nsError = error as NSError? {
            // self.presentAlert("Face Landmark Detection Error", error: nsError)
            return
        }
        // Perform drawing on the main thread.
        //DispatchQueue.main.async {
        if let faces = request?.results as? [VNFaceObservation] {
            for faceObservation in faces {
                print("bounding", faceObservation.boundingBox)
                boundingBox = faceObservation.boundingBox
                let eye = faceObservation.landmarks?.leftEye
                landmark = faceObservation.landmarks
                print(eye?.precisionEstimatesPerPoint)
            }
        }
        
    }
    
    /// - Tag: CreateRequests
    fileprivate func createVisionRequests(faceLandmarkRequest: VNDetectFaceLandmarksRequest) -> [VNRequest] {
        
        // Create an array to collect all desired requests.
        var requests: [VNRequest] = []
        
        requests.append(faceLandmarkRequest)

        // Return grouped requests as a single array.
        return requests
    }
    
    /// - Tag: PerformRequests
    func performVisionRequest(image: CGImage, orientation: CGImagePropertyOrientation, faceLandmarkRequest: VNDetectFaceLandmarksRequest) {
        
        // Fetch desired requests based on switch status.
        let requests = createVisionRequests(faceLandmarkRequest: faceLandmarkRequest)
        // Create a request handler.
        let imageRequestHandler = VNImageRequestHandler(cgImage: image,
                                                        orientation: orientation,
                                                        options: [:])
        
        // Send the requests to the request handler.
        //DispatchQueue.global(qos: .userInitiated).async {
            do {
                try imageRequestHandler.perform(requests)
            } catch let error as NSError {
                print("Failed to perform image request: \(error)")
                //self.presentAlert("Image Request Failed", error: error)
                return
            }
        //}
    }
    
    func detect(filename: String) {
        /// - Tag: ConfigureCompletionHandler
        let faceLandmarkRequest = VNDetectFaceLandmarksRequest(completionHandler: handleDetectedFaceLandmarks)
        
        if let dataProvider = CGDataProvider(filename: filename) {
            if let cgImage = CGImage(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent) {
                performVisionRequest(image: cgImage, orientation: CGImagePropertyOrientation.down, faceLandmarkRequest: faceLandmarkRequest)
            }
            print("finish")
        }


        let image = NSImage(byReferencingFile: "/Users/s04118/Documents/project/test_command_line_tool/yasu.jpg")
    }
}
