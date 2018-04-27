//
//  BuildCreator.swift
//  FBSnapshotsViewer
//
//  Created by Anton Domashnev on 24.06.17.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Foundation

class BuildCreator {
    var date: Date?
    var applicationName: String?
    var fbReferenceImageDirectoryURLs: [URL]?
    
    func createBuild() -> Build? {
        return Build(date: date ?? Date(),
                     applicationName: applicationName ?? "Unknown",
                     fbReferenceImageDirectoryURLs: fbReferenceImageDirectoryURLs ?? [])
    }
}
