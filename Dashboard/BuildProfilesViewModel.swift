//
//  BuildProfilesViewModel.swift
//  Dashboard
//
//  Created by Mustafa on 19.08.2022.
//  Copyright © 2022 Appcircle Inc. All rights reserved.
//

import Foundation

class BuildProfilesViewModel {
    
    func loadBuildProfiles(page:Int) async throws-> BuildProfiles {
        let endpint = AppcircleAPI.buildprofiles(page: page).endpoint
        let result:BuildProfiles = try await Networking.shared.loadAuthorized(endpint)
        return result
    }
}


func loadBuildProfiles(page:Int) async throws-> BuildProfiles {
    let endpint = AppcircleAPI.buildprofiles(page: page).endpoint
    let result:BuildProfiles = try await Networking.shared.loadAuthorized(endpint)
    return result
}
