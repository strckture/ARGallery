//
//  ControlView.swift
//  ARGallery
//
//  Created by pascal struck on 05.08.21.
//

import SwiftUI

struct ControlView: View {
    
    @EnvironmentObject var arViewController: ARViewController
    
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack {
            
            ResetButton()
            
            Spacer()
            
            ControlButtonBar(showBrowse: $showBrowse, showSettings: $showSettings)
            
        }
        .onAppear {
            #if DEBUG
            // Observe anchors for better understanding what’s happening
            let anchors = self.arViewController.arView.scene.anchors
            for anchor in anchors {
                print("\n\(anchor)\n")
            }
            #endif
        }
    }
    
}

struct ResetButton: View {
    
    @EnvironmentObject var arViewController: ARViewController
    
    @ScaledMetric(relativeTo: .body) private var relativeImageHeight: CGFloat = 38.0
    
    let haptic = Haptic()
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button(action: {
                
                self.arViewController.resetScene()
                self.haptic.simpleSucess()
                
            }, label: {
                ZStack {
                    Color(.blue)
                        .opacity(0.00001)
                        .frame(width: 50, height: 50)
                    VStack (spacing: .zero) {
                        
                        VStack (spacing: .zero) {
                            Spacer()
                            Image(systemName: "trash.fill")
                                .imageScale(.large)
                                //.font(.system(size: 26))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height: self.relativeImageHeight)
                        //.background(Color.green.opacity(0.3))
                        
                        Text("Clear")
                            .font(Font.caption.weight(.semibold))
                            .foregroundColor(.white)
                    }
                }
//                .frame(width: 60, height: 50)
            })
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 80)
            .padding(.trailing, 20)
//            .background(Color.blue.opacity(0.2))
        }
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
    @ScaledMetric(relativeTo: .body) private var relativeImageHeight: CGFloat = 38.0
    
    let systemIconName: String
    let description: String
    let action: () -> Void
    
    let haptic = Haptic()
    
    var body: some View {
        
            Button(action: {
                self.action()
                self.haptic.simpleSucess()
            }, label: {
                ZStack {
                    Color(.blue)
                        .opacity(0.00001)
                        .frame(width: 50, height: 50)
                    
                    VStack (spacing: .zero){
                        
                        VStack (spacing: .zero) {
                            Spacer()
                            Image(systemName: systemIconName)
                                .imageScale(.large)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height: self.relativeImageHeight)
                        
                        Text(description)
                            .font(Font.caption.weight(.semibold))
                            .foregroundColor(.white)
                    }
                }
            })
            .buttonStyle(PlainButtonStyle())
            .padding(12.0)
//            .background(Color.blue.opacity(0.2))
        
    }
}

struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @ScaledMetric(relativeTo: .body) private var relativeImageHeight: CGFloat = 38.0
    
    let haptic = Haptic()
    
    var body: some View {
        
        Button(action: {
            print("Most Recently Button pressed")
            self.haptic.simpleSucess()
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }, label: {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                ZStack {
                    Color(.blue)
                        .opacity(0.00001)
                        .frame(width: 50, height: 50)
                    
                    VStack (spacing: .zero) {
                        
                        VStack (spacing: .zero) {
                            Spacer()
                            Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                                .resizable()
                                .imageScale(.large)
                                .aspectRatio(1/1, contentMode: .fit)
                                //                        .border(Color.white, width: 2)
                                .background(Color.white)
                                .cornerRadius(3.0)
                            Spacer()
                        }
                        .frame(height: self.relativeImageHeight)
                        //                    .background(Color.green.opacity(0.3))
                        
                        Text("Recent")
                            .font(Font.caption.weight(.semibold))
                            //                      .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundColor(.white)
                    }
                }
            } else {
                ZStack {
                    Color(.blue)
                        .opacity(0.00001)
                        .frame(width: 50, height: 50)
                    
                    VStack (spacing: .zero) {
                        
                        VStack (spacing: .zero) {
                            Spacer()
                            Image(systemName: "clock.fill")
                                //.font(.system(size: 26))
                                .imageScale(.large)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .frame(height: self.relativeImageHeight)
                        //.background(Color.green.opacity(0.3))
                        
                        Text("Recent")
                            .font(Font.caption.weight(.semibold))
                            .foregroundColor(.white)
                    }
                }
            }
        })
        .buttonStyle(PlainButtonStyle())
        .padding(12.0)
//        .background(Color.blue.opacity(0.2))
//        .border(Color.white, width: 2)
//        .background(Color.white.opacity(0.7))
    }
}


class Haptic {
    func simpleSucess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}


//
