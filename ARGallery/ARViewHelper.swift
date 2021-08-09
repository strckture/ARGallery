

// 'ARViewHelper.swift' by Martin Lexow (2021)


import Foundation
import os.log


fileprivate let logger = Logger(subsystem: "", category: "ARViewHelper")


final class ARViewHelper: ObservableObject {
    
    
    private let deleteModelsCompletion: () -> ()
    // () -> () defines a parameter that is a function, and that returns void (nothing)
    
    
    init(onDelete: @escaping() -> ()) {
        
        logger.debug("ARViewHelper init")
        
        self.deleteModelsCompletion = onDelete
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(deleteModelsNotificationReceived(_:)),
                                       name: NSNotification.Name.deleteModels,
                                       object: nil)
        
    }
    
    
    @objc private func deleteModelsNotificationReceived(_ sender: Any?) {
        logger.debug("deleteModelsNotificationReceived")
        self.deleteModelsCompletion()
    }
    
    
}
