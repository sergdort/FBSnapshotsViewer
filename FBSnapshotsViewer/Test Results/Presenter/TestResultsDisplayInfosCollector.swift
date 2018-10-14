//
//  TestResultsDisplayInfoCollector.swift
//  FBSnapshotsViewer
//
//  Created by Anton Domashnev on 11.06.17.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Foundation

class TestResultsDisplayInfosCollector {
    // MARK: - Helpers
    
    private func groupTestResultsByAssociatedSectionTitle(_ testResults: [SnapshotTestResult]) -> [TestResultsSectionTitleDisplayInfo: [TestResultDisplayInfo]] {
        var temporaryDictionary: [TestResultsSectionTitleDisplayInfo: [TestResultDisplayInfo]] = [:]
        testResults.forEach {
            let testResultInfo = TestResultDisplayInfo(testResult: $0)
            let titleInfo = TestResultsSectionTitleDisplayInfo(build: $0.build, testContext: testResultInfo.testContext)
            if var testResultInfos = temporaryDictionary[titleInfo] {
                testResultInfos.append(testResultInfo)
                temporaryDictionary[titleInfo] = testResultInfos
            }
            else {
                temporaryDictionary[titleInfo] = [testResultInfo]
            }
        }
        return temporaryDictionary
    }
    
    private func createSectionDisplayInfos(with groupedTestResults: [TestResultsSectionTitleDisplayInfo: [TestResultDisplayInfo]]) -> [TestResultsSectionDisplayInfo] {
        return groupedTestResults
            .map { TestResultsSectionDisplayInfo(title: $0.key, items: $0.value) }
            .sorted { (lhs, rhs) in
                let timeAgo1 = lhs.titleInfo.timeAgoDate
                let timeAgo2 = rhs.titleInfo.timeAgoDate
                return timeAgo1 != timeAgo2 ? timeAgo1 >= timeAgo2 : lhs.titleInfo.title > rhs.titleInfo.title
            }
    }
    
    // MARK: - Interface
    
    func collect(testResults: [SnapshotTestResult] = []) -> [TestResultsSectionDisplayInfo] {
        let goupedDictionary = groupTestResultsByAssociatedSectionTitle(testResults)
        return createSectionDisplayInfos(with: goupedDictionary)
    }
}
