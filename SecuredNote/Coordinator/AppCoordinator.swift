//
//  AppCoordinator.swift
//  SecuredNotes
//
//  Created by CHANDRA SEKARAN M on 14/06/2024.
//

import Foundation
import SwiftUI

class AppCoordinator {
    
    func root() -> some View  {
        return BioMetricSecurityUIView(viewModel: BioMetricSecurityViewModel())
    }
    
}
