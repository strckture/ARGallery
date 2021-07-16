//
//  View+Extensions.swift
//  ARGallery
//
//  Created by pascal struck on 20.06.21.
//

import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
