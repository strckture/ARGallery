//
//  Model.swift
//  ARGallery
//
//  Created by pascal struck on 24.05.21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case Expressionism
    case Impressionism
    case PopArt
    case Surrealism
    case Other
    
    var label: String {
        get {
            switch self {
            case .Expressionism:
                return "Expressionism"
            case .Impressionism:
                return "Impressionism"
            case .PopArt:
                return "Pop Art"
            case .Surrealism:
                return "Surrealism"
            case .Other:
                return "Other"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0){
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion {
                case .failure(let error): print("Unable to load \(filename).Error: \(error.localizedDescription)")
                case .finished:
                    break
                }

            }, receiveValue: { modelEntity in

                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation

                print("modelentity for \(self.name) has been loaded")
            })
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //Expressionism
        let blaue_reiter = Model(name: "blaue_reiter", category: .Expressionism, scaleCompensation: 2.0)
        let improvisation = Model(name: "improvisation", category: .Expressionism, scaleCompensation: 2.0)
        let schrei = Model(name: "schrei", category: .Expressionism, scaleCompensation: 2.0)
        
        self.all += [blaue_reiter, improvisation, schrei]
        
        //Impressionism
        let sunrise = Model(name: "sunrise", category: .Impressionism, scaleCompensation: 2.0)
        let coquelicots = Model(name: "coquelicots", category: .Impressionism, scaleCompensation: 2.0)
        let water_lillies = Model(name: "water_lillies", category: .Impressionism, scaleCompensation: 2.0)

        self.all += [sunrise, coquelicots, water_lillies]
        
        //PopArt
        let we_always_see_with_memory = Model(name: "we_always_see_with_memory", category: .PopArt, scaleCompensation: 2.0)
        let radiant_baby = Model(name: "radiant_baby", category: .PopArt, scaleCompensation: 2.0)
        let soup = Model(name: "soup", category: .PopArt, scaleCompensation: 2.0)
        
        self.all += [we_always_see_with_memory, radiant_baby, soup]
        
        //Surrealism
        let egg_in_the_church = Model(name: "egg_in_the_church", category: .Surrealism, scaleCompensation: 2.0)
        let persistence_of_memory = Model(name: "persistence_of_memory", category: .Surrealism, scaleCompensation: 2.0)
        let not_a_pipe = Model(name: "not_a_pipe", category: .Surrealism, scaleCompensation: 2.0)
        
        self.all += [egg_in_the_church, persistence_of_memory, not_a_pipe]
        
        //Other
        let spaceship_ak5 = Model(name: "spaceship_ak5", category: .Other, scaleCompensation: 0.1)
        
        self.all += [spaceship_ak5]
        
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
}
