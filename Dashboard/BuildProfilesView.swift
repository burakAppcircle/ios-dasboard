//
//  BuildProfilesView.swift
//  Dashboard
//
//  Created by Mustafa on 18.08.2022.
//

import SwiftUI

struct BuildProfilesView: View {
    @State var profiles = [BuildProfile]()
    @State var currentPage = 1
    
    var body: some View {
        ZStack {
            Button  {

                Task {
                    print("Task started")
                    do {
                        let buildProfiles = try await loadBuildProfiles(page: currentPage)
                        currentPage = buildProfiles.pagination.page
                        profiles = buildProfiles.data
                        print("Task finished")

                    } catch {
                        print("Error \(error)")
                    }
                }
            } label: {
                Text("Get it")
            }.zIndex(1)
            List (profiles) { profile in
                BuildProfileCellView(profile: profile)
                .task {
                    if profile == profiles.last {
                        currentPage += 1
    //                    movies += await loadMovies (page: currentPage)
                    }
                }
            }.task {
    //            movies = await loadMovies()
            }.refreshable {
    //            movies = await loadMovies()
            }

        }
    }
}

struct BuildProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        BuildProfilesView()
    }
}
