//
//  SessionSettings.swift
//  ARGallery
//
//  Created by pascal struck on 21.06.21.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectOcclusionEnabled: Bool = false
    @Published var isLidarDebugEnabled: Bool = false
}
