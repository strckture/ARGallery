//
//  ContentView.swift
//  ARGallery
//
//  Created by pascal struck on 10.05.21.
//

import SwiftUI
import RealityKit
import os.log


fileprivate let logger = Logger(subsystem: "", category: "ARViewContainer")


struct ContentView: View {
    
    @EnvironmentObject var arViewController: ARViewController
    @EnvironmentObject var placementSettings: PlacementSettings
    
    @State private var showBrowse: Bool = false
    @State private var showSettings: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ARViewContainer()
            
            if self.placementSettings.selectedModel == nil {
                ControlView(showBrowse: self.$showBrowse, showSettings: self.$showSettings)
            } else {
                PlacementView()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}



// MARK: - AR View Container

struct ARViewContainer: UIViewRepresentable {
    
    
    @EnvironmentObject var arViewController: ARViewController
    @EnvironmentObject var placementSettings: PlacementSettings
    //@EnvironmentObject var sessionSettings: SessionSettings
    
    
    func makeUIView(context: Context) -> CustomARView {
        
        logger.debug("makeUIView")
        
        let arView = self.arViewController.arView
        
        // Subscribe to SceneEvents.Update
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, {
            (event) in
            self.updateScene(for: arView)
        })
        
        return arView
        
    }
    
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        logger.debug("updateUIView")
    }
    
    
    private func updateScene(for arView: CustomARView) {
        
        // logger.debug("updateScene")
        
        // Only display focusEntity when the user has selected a model for placement
        self.arViewController.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        // Add model to scene if confirmed for placement
        if let confirmedModel = self.placementSettings.confirmedModel,
           let modelEntity = confirmedModel.modelEntity {
            self.place(modelEntity, in: arView)
            self.placementSettings.confirmedModel = nil
        }
        
    }
    
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView) {
        
        logger.debug("place modelEntity")
        
        // 1. Clone modelEntity. This creates an identical copy of modelEntity and references the same model. This also allows to have multiple models of the same asset in the scene.
        let clonedEntity = modelEntity.clone(recursive: true)
        
        // 2. Enable translation and rotation gestures.
//!     // restrict rotation?
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation, .scale], for: clonedEntity)
        
        // 3. Create an anchorEntity and add a clonedEntity to the anchorEntity
//!     // restrict anchor?
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        // 4. Add the anchorEntity to the arView.scene
        arView.scene.addAnchor(anchorEntity)
        
    }
    
    
//    func deleteAllModels(for arView: CustomARView) {
//
//        logger.debug("deleteAllModels")
//        arView.scene.anchors.removeAll()
//
//    }
    
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(PlacementSettings())
//            .environmentObject(SessionSettings())
//    }
//}



// TODOS:
// !done settings
// !done touch targets?
//       btn description spacing
//       custom FocusEntity texture (green/red?)
//       ResetButton: delete all anchorEntities

//V1-----------------------------------------------------

//       ImportButton: import photos -> convert to usdz
//       SelectView: select 3D Models to perform actions
//       SelectView -> size: show realworld measurements

