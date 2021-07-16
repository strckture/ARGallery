//
//  SettingsView.swift
//  ARGallery
//
//  Created by pascal struck on 21.06.21.
//

import SwiftUI

enum Setting {
    case peopleOcclusion
    case objectOcclusion
    case lidarDebug
    
    var label: String{
        get {
            switch self {
            case .peopleOcclusion, .objectOcclusion:
                return "Occlusion"
            case .lidarDebug:
                return "LiDAR"
            }
        }
    }
    var systemIconName: String {
        get {
            switch self {
            case .peopleOcclusion:
                return "person.fill"
                
            case .objectOcclusion:
                return "cube.fill"
                
            case .lidarDebug:
                return "rays"
            }
        }
    }
}

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            SettingsGrid()
                .navigationBarTitle(Text("Settings"), displayMode: .inline)
//                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showSettings.toggle()
                    }) {
                        Text("Done").bold()
                    })
                    
        }
    }
    
}

struct SettingsGrid: View {
    @EnvironmentObject var sessionSettings: SessionSettings
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: gridItemLayout, spacing: 25) {
                
                SettingToggleButton(setting: .peopleOcclusion, isOn: $sessionSettings.isPeopleOcclusionEnabled)
                
                SettingToggleButton(setting: .objectOcclusion, isOn: $sessionSettings.isObjectOcclusionEnabled)
                
                SettingToggleButton(setting: .lidarDebug, isOn: $sessionSettings.isLidarDebugEnabled)
            }
        }
        .padding(.top, 35)
    }
}



struct SettingToggleButton: View {
    let setting: Setting
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self .isOn.toggle()
            print("\(#file) - \(setting): \(self.isOn)")
        }) {
            VStack{
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? Color(UIColor.systemBlue) : Color(UIColor.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                
                Text(setting.label)
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top, 5)
            }
        }
        .frame(width: 100, height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20)
    }
}
