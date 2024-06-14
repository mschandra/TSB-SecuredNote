//
//  BioMetricSecurityViewModel.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 12/06/2024.
//

import Foundation
import LocalAuthentication


protocol SecurityViewModel {
    var isUnlocked: Bool { get set }
    func unlock()
}
@Observable
class BioMetricSecurityViewModel: SecurityViewModel {
    
    var isUnlocked = false
    var isSettingsDisabled = false
    
    func unlock() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock to see the notes") { success, authenticationError in
                self.isUnlocked = success
            }
        } else {
            self.isSettingsDisabled = true
        }
    }
    
}
