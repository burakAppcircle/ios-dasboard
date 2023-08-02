//
//  BuildProfileCellView.swift
//  Dashboard
//
//  Created by Mustafa on 18.08.2022.
//

import SwiftUI

struct BuildProfileCellView: View {
    var profile:BuildProfile
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "applelogo")
                Text(profile.name)
            }
            HStack {
                Text("Last Build:")
                    .font(.caption)
                    .fontWeight(.bold)

                Text(profile.lastBuildDate?.formatted(date: .abbreviated, time: .shortened) ?? "Unknown")
                    .font(.caption)
                Text(profile.buildStatus == 0 ? "Success" : "Failed")
                    .font(.caption2)
                    .foregroundColor(profile.buildStatus == 0 ? .green: .red)

            }
        }
    }
}

struct BuildProfileCellView_Previews: PreviewProvider {
    static var previews: some View {
        BuildProfileCellView(profile: BuildProfile(id:  "1", organizationId: "123", name: "iOS", os: 1,
                                                   buildPlatformType: 1, gitProviderName: "git", repositoryName: "asdsad", repositoryUrl: "abcd", autoDistributeCount: 1,
                                                   autoStoreSubmitCount: 2, autoBuildCount: 3, createDate: Date(),
                                                   lastBuildDate: Date(), buildStatus: 1, pinned: true, branches: ["main", "develop"], hookId: nil, buildCount: 55,
                                                   profileSettings: ProfileSettings(pullRequestSettings: [], pushSettings: [], tagSettings: []), workflowCount: 3))
    }
}
