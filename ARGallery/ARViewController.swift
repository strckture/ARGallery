

// 'ARViewController.swift' by Martin Lexow (2021)


import Foundation
import ARKit
import RealityKit
import FocusEntity
import Combine
import os.log


fileprivate let logger = Logger(subsystem: "", category: "ARViewController")


final class ARViewController: ObservableObject {
    
    
    // ARView
    let arView: CustomARView = CustomARView(frame: .zero)
    
    
    // Focus Entity
    var focusEntity: FocusEntity? = nil
    
    
    init() {
        
        logger.debug("ARViewController init")
        
        self.configureARView()
        self.configureFocusEntity()
        
        // let _ = self.togglePeopleOcclusion()
        // let _ = self.toggleObjectOcclusion()
        // let _ = self.toggleLidarDebug()
        
    }
    
    
    private func configureARView() {
        
        logger.debug("configureARView")
        
        // Session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [ .horizontal, .vertical]
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh){
            config.sceneReconstruction = .mesh
        }
        self.arView.session.run(config)
        
    }
    
    
    private func configureFocusEntity() {
        self.focusEntity = FocusEntity(on: self.arView, style: .colored(onColor: .color(.systemGreen),
                                                                        offColor: .color(.systemGreen),
                                                                        nonTrackingColor: .color(.systemRed)))
    }
    
    
    var addedAnchorsName: [String] = [String]() {
        didSet {
            logger.debug("didSet addedAnchorsName: \(self.addedAnchorsName)")
        }
    }
    
    
    func resetScene() {
        let oldAddedAnchorsName = self.addedAnchorsName
        for a in 0..<oldAddedAnchorsName.count {
            let anchorName = oldAddedAnchorsName[a]
            if let index = arView.scene.anchors.firstIndex(where: { $0.name == anchorName }) {
                arView.scene.anchors.remove(at: index)
                self.addedAnchorsName.removeAll(where: { $0 == anchorName })
            } else {
                logger.error("Unable to find anchor with name '\(anchorName)'")
            }
        }
    }
    
    
    // LiDAR
    
    @Published var deviceHasLiDAR: Bool = {
        return ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh)
    }()
    
    
    // MARK: - Toggle Methods
    
    @Published var peopleOcclusionIsEnabled: Bool = false
    
    func togglePeopleOcclusion() -> Bool {
        
        logger.debug("togglePeopleOcclusion")
        
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            return false
        }
        
        guard let config = self.arView.session.configuration as? ARWorldTrackingConfiguration else {
            return false
        }
        
        if config.frameSemantics.contains(.personSegmentationWithDepth) {
            config.frameSemantics.remove(.personSegmentationWithDepth)
            self.arView.session.run(config)
            self.peopleOcclusionIsEnabled = false
            return false
        } else {
            config.frameSemantics.insert(.personSegmentationWithDepth)
            self.arView.session.run(config)
            self.peopleOcclusionIsEnabled = true
            return true
        }
        
    }
    
    
    func toggleObjectOcclusion() -> Bool {
        
        logger.debug("toggleObjectOcclusion")
        
        // TODO: - Needs LiDAR?
        
        if self.arView.environment.sceneUnderstanding.options.contains(.occlusion) {
            self.arView.environment.sceneUnderstanding.options.remove(.occlusion)
            return false
        } else {
            self.arView.environment.sceneUnderstanding.options.insert(.occlusion)
            return true
        }
    }
    
    
    func toggleLidarDebug() -> Bool {
        
        logger.debug("toggleLidarDebug")
        
        if self.arView.debugOptions.contains(.showSceneUnderstanding) {
            self.arView.debugOptions.remove(.showSceneUnderstanding)
            return false
        } else {
            self.arView.debugOptions.insert(.showSceneUnderstanding)
            return true
        }
        
    }
    
    
    
}
