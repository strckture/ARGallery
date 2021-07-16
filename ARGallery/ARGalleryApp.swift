//
//  ARGalleryApp.swift
//  ARGallery
//
//  Created by pascal struck on 10.05.21.
//

import SwiftUI

@main
struct ARGalleryApp: App {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
        }
    }
}
