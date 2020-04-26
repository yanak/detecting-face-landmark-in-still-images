//
//  AppDelegate.swift
//  DetectingFaceLandmarkInStillImages
//
//  Created by 田中 穏識 on 2020/03/30.
//  Copyright © 2020 田中 穏識. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let landmark = Landmark()
        // let res = landmark.detect(filename: "/Users/s04118/yasu.jpg")
        //let image = UserData().featureImage
        landmark.detect(filename: "/Users/s04118/yasu.jpg")
        // let l = landmark.landmark!
        
        let contentView = ContentView(image: UserData().featureImage, landmarks: landmark)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


struct AppDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
