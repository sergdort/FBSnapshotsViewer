//
//  SnapshotTestResult.swift
//  FBSnapshotsViewer
//
//  Created by Anton Domashnev on 05/02/2017.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Cocoa

struct SnapshotTestInformation: AutoEquatable {
    let testClassName: String
    let testName: String
    let testFilePath: String
    let testLineNumber: Int
}

enum SnapshotTestResult: Equatable {
    var testClassName: String {
        return testInformation.testClassName
    }
    
    var testName: String {
        return testInformation.testName
    }
    
    var testFilePath: String {
        return testInformation.testFilePath
    }
    
    var testLineNumber: Int {
        return testInformation.testLineNumber
    }
    
    var testInformation: SnapshotTestInformation {
        switch self {
        case let .recorded(testInformation, _, _):
            return testInformation
        case let .failed(testInformation, _, _, _, _):
            return testInformation
        }
    }
    
    var build: Build {
        switch self {
        case let .recorded(_, _, build):
            return build
        case let .failed(_, _, _, _, build):
            return build
        }
    }

    case recorded(testInformation: SnapshotTestInformation,
                  referenceImagePath: String,
                  build: Build)

    case failed(testInformation: SnapshotTestInformation,
                referenceImagePath: String,
                diffImagePath: String,
                failedImagePath: String,
                build: Build)
    
    static func hasSamePath(lhs: SnapshotTestResult, rhs: SnapshotTestResult) -> Bool {
        switch (lhs, rhs) {
        case let (.recorded(_, lhsReferenceImagePath, _), .recorded(_, rhsReferenceImagePath, _)):
            return lhsReferenceImagePath == rhsReferenceImagePath
        case let (.failed(_, lhsReferenceImagePath, lhsdiffImagePath, lhsFailedImagePath, _),
                  .failed(_, rhsReferenceImagePath, rhsdiffImagePath, rhsFailedImagePath, _)):
            return lhsReferenceImagePath == rhsReferenceImagePath &&
                lhsdiffImagePath == rhsdiffImagePath &&
                lhsFailedImagePath == rhsFailedImagePath
        default:
            return false
        }
    }
}
