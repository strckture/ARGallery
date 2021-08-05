//
//  ControlView.swift
//  ARGallery
//
//  Created by pascal struck on 05.08.21.
//

import SwiftUI

struct ControlView: View {
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack {
            
            ResetButton()
            
            Spacer()
            
            ControlButtonBar(showBrowse: $showBrowse, showSettings: $showSettings)
        }
    }
}

struct ResetButton: View {
    let haptic = Haptic()
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button(action: {
                print("tactical nuke!")
                NotificationCenter.default.post(name: .deleteModels, object: nil)
                self.haptic.simpleSucess()
                
            }) {
                VStack (spacing: 5) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 26, height: 26)
                    
                    Text("Clear")
                        .font(.footnote)
                        .foregroundColor(.white)
//                        .padding(.top, 2)
                }
                .frame(width: 60, height: 50)
            }
        }
        .padding(.top, 80)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    
    var body: some View {
        HStack {
            Spacer()
            
            //Recently Placed Button
            MostRecentlyPlacedButton().hidden(self.placementSettings.recentlyPlaced.isEmpty)
            
            Spacer()
            
            //Browse Button
            ControlButton(systemIconName: "square.grid.2x2.fill", description: "Browse") {
                print("browse!")
                self.showBrowse.toggle()
            }.sheet(isPresented: $showBrowse, content: {
                //BrowseView
                BrowseView(showBrowse: $showBrowse)
            })
            
            Spacer()
            
            ControlButton(systemIconName: "gearshape.fill", description: "Settings") {
                print("settings!")
                self.showSettings.toggle()
            } .sheet(isPresented: $showSettings) {
                SettingsView(showSettings: $showSettings)
            }
            
            Spacer()
        }
        .frame(maxWidth: 500)
        .padding(30)
        .padding(.bottom, 30)
    }
}


struct ControlButton: View {
    let systemIconName: String
    let description: String
    let action: () -> Void
    
    let haptic = Haptic()
    
    var body: some View {
        
            Button(action: {
                self.action()
                self.haptic.simpleSucess()
            }) {
                VStack (spacing: 5){
                    Image(systemName: systemIconName)
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 26, height: 26)
//                        .padding(.bottom, 2)
                    
                    Text(description)
                        .font(.footnote)
                        .foregroundColor(.white)
//                        .padding(.top, 2)
                }
            }.frame(width: 60, height: 50)
    }
}

struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    let haptic = Haptic()
    
    var body: some View {
        
        Button(action: {
            print("Most Recently Button pressed")
            self.haptic.simpleSucess()
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }) {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                VStack {
                    Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                        .resizable()
                        .frame(width: 26)
                        .aspectRatio(1/1, contentMode: .fit)
//                        .border(Color.white, width: 2)
                        .background(Color.white)
                        .cornerRadius(3.0)
                    
                    Text("Recent")
//                        .font(.system(size: 12, weight: .medium, design: .default))
                        .font(.footnote)
                        .foregroundColor(.white)
//                        .padding(.top, 2)
                }
            } else {
                VStack {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 26, height: 26)
                    
                    Text("Recent")
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 2)
                }
            }
        }
        .frame(width: 60, height: 50)
//        .border(Color.white, width: 2)
//        .background(Color.white.opacity(0.7))
    }
}


class Haptic {
    func simpleSucess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        print("bzzz bzzz")
    }
}


//
