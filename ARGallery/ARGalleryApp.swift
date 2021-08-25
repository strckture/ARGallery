//
//  ARGalleryApp.swift
//  ARGallery
//
//  Created by pascal struck on 10.05.21.
//


import SwiftUI


@main
struct ARGalleryApp: App {
    
    @StateObject private var arViewHelper: ARViewController = ARViewController()
    @StateObject var placementSettings = PlacementSettings()
    //@StateObject var sessionSettings = SessionSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.arViewHelper)
                .environmentObject(self.placementSettings)
                //.environmentObject(self.sessionSettings)
        }
    }
    
}
