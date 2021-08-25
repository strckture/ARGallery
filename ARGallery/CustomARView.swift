//
//  CustomARView.swift
//  ARGallery
//
//  Created by pascal struck on 19.06.21.
//

import RealityKit
import ARKit
import FocusEntity
import SwiftUI
import Combine


final class CustomARView: ARView {
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
