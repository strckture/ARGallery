//
//  SettingsView.swift
//  ARGallery
//
//  Created by pascal struck on 21.06.21.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var arViewController: ARViewController
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            SettingsGrid()
                .environmentObject(self.arViewController)
                .navigationBarTitle(Text("Settings"), displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.showSettings.toggle()
                                        }) {
                                            Text("Done").bold()
                                        })
            
//            Text("Some features may be unavailable to you, if you are using an older device.")
//                .font(.body)
//                .multilineTextAlignment(.leading)
//                .foregroundColor(.secondary)
//                .padding()
//            }
        }
    }
    
}



struct SettingsGrid: View {
    
    @EnvironmentObject var arViewController: ARViewController
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        return Form {
//            Text("LiDAR support: \(self.arViewController.deviceHasLiDAR ? "YES" : "NO")")
            Section(footer: Text("DISCLAIMER: Some features may be unavailable to you, if you are using an older device.")) {
            
                Button(action: {
                    let state = self.arViewController.togglePeopleOcclusion()
                    print("togglePeopleOcclusion \(state)")
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: self.arViewController.peopleOcclusionIsEnabled ? "person.fill.checkmark" : "person.fill.xmark")
                            .font(.system(size: 16))
                            .foregroundColor(self.arViewController.peopleOcclusionIsEnabled ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                            .buttonStyle(PlainButtonStyle())
                        Text("People Occlusion")
                            .foregroundColor(self.arViewController.peopleOcclusionIsEnabled ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                    }
                })
                
                if self.arViewController.deviceHasLiDAR {
                    Button(action: {
                        let state = self.arViewController.toggleObjectOcclusion()
                        print("toggleObjectOcclusion \(state)")
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: self.arViewController.objectOcclusionIsEnabled ? "cube.fill" : "cube.transparent.fill")
                                .font(.system(size: 16))
                                .foregroundColor(self.arViewController.objectOcclusionIsEnabled ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                                .buttonStyle(PlainButtonStyle())
                            Text("Object Occlusion")
                                .foregroundColor(self.arViewController.objectOcclusionIsEnabled ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                        }
                    })
//                    .disabled(!self.arViewController.deviceHasLiDAR)
                }
                
                
                if self.arViewController.deviceHasLiDAR {
                    Button(action: {
                        let state = self.arViewController.toggleLidarDebug()
                        print("toggleLidarDebug \(state)")
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: self.arViewController.LidarIsEnabled ? "light.max" : "light.min")
                                .font(.system(size: 16))
                                .foregroundColor(self.arViewController.LidarIsEnabled ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                                .buttonStyle(PlainButtonStyle())
                            Text("LiDAR Mesh")
                                .foregroundColor(self.arViewController.LidarIsEnabled ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                        }
                    })
//                    .disabled(!self.arViewController.deviceHasLiDAR)
                }
            }
            
        }
        
    }
}



//Grid buttons---------------------------------------------------------------------------------

// @EnvironmentObject var sessionSettings: SessionSettings
// private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
        
//enum Setting {
//    case peopleOcclusion
//    case objectOcclusion
//    case lidarDebug
//
//    var label: String{
//        get {
//            switch self {
//            case .peopleOcclusion, .objectOcclusion:
//                return "Occlusion"
//            case .lidarDebug:
//                return "LiDAR"
//            }
//        }
//    }
//    var systemIconName: String {
//        get {
//            switch self {
//            case .peopleOcclusion:
//                return "person.fill"
//
//            case .objectOcclusion:
//                return "cube.fill"
//
//            case .lidarDebug:
//                return "rays"
//            }
//        }
//    }
//}
        
//        ScrollView {
//
//            LazyVGrid(columns: gridItemLayout, spacing: 25) {
//
//                // SettingToggleButton()
//                // SettingToggleButton()
//                // SettingToggleButton()
//
//            }
//        }
//        .padding(.top, 35)
//    }
//}

//struct SettingToggleButton: View {
//
//    let setting: Setting
//    @Binding var isOn: Bool
//
//    var body: some View {
//        Button(action: {
//            self .isOn.toggle()
//            print("\(#file) - \(setting): \(self.isOn)")
//        }) {
//            VStack{
//                Image(systemName: setting.systemIconName)
//                    .font(.system(size: 35))
//                    .foregroundColor(self.isOn ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
//                    .buttonStyle(PlainButtonStyle())
//
//                Text(setting.label)
//                    .font(.system(size: 17, weight: .medium, design: .default))
//                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
//                    .padding(.top, 5)
//            }
//        }
//        .frame(width: 100, height: 100)
//        .background(Color(UIColor.secondarySystemFill))
//        .cornerRadius(20)
//    }
//
//}
