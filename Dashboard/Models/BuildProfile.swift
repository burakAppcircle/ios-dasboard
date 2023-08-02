//
//  BuildProfile.swift
//  Dashboard
//
//  Created by Mustafa on 17.08.2022.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

struct PullRequestSetting: Codable {
    let sourceBranches: [String]
    let targetBranch, wokflowId: String
}

struct PushSetting: Codable {
    let branchName, wokflowId: String
    let defaultSettingBranch: String?
}

struct ProfileSettings: Codable {
    let pullRequestSettings: [PullRequestSetting]
    let pushSettings: [PushSetting]
    let tagSettings: [String]
}

struct BuildProfile: Codable,Identifiable,Equatable {
    static func == (lhs: BuildProfile, rhs: BuildProfile) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id, organizationId, name: String
    let os, buildPlatformType: Int
    let gitProviderName, repositoryName: String
    let repositoryUrl: String
    let autoDistributeCount, autoStoreSubmitCount, autoBuildCount: Int
    let createDate: Date?
    let lastBuildDate: Date?
    let buildStatus: Int
    let pinned: Bool
    let branches: [String]
    let hookId: String?
    let buildCount: Int
    let profileSettings: ProfileSettings
    let workflowCount: Int
}

struct Pagination: Codable {
    let page, perPage, pageCount, totalCount: Int
    let enablePrevious, enableNext: Bool
}

struct BuildProfiles: Codable {
    let pagination: Pagination
    let data: [BuildProfile]
}

let json = """
{
      "id": "f226d049-240c-4b8f-a5d4-89cb98117f82",
      "organizationId": "14501015-b30c-43af-803b-da32ca0eb7b8",
      "name": "Testiossms",
      "os": 1,
      "buildPlatformType": 1,
      "gitProviderName": "GithubApp",
      "repositoryName": "tosbaha/Smsblocker",
      "repositoryUrl": "https://github.com/tosbaha/Smsblocker.git",
      "autoDistributeCount": 1,
      "autoStoreSubmitCount": 0,
      "autoBuildCount": 0,
      "createDate": "2021-11-01T11:39:58.9105171+00:00",
      "lastBuildDate": "2022-07-28T12:40:10.5555878+00:00",
      "buildStatus": 0,
      "pinned": true,
      "branches": [],
      "hookId": "326273898",
      "buildCount": 54,
      "profileSettings": {
        "pullRequestSettings": [],
        "pushSettings": [],
        "tagSettings": []
      },
      "workflowCount": 0
    }
"""
