//
//  walkie_talkieTests.swift
//  walkie-talkieTests
//
//  Created by Nika Elashvili on 10/2/21.
//

import XCTest
@testable import walkie_talkie

class walkie_talkieTests: XCTestCase {

    func testExample() throws {
        let testData =  [
            Message(id: 1, username_from: "test_1", timestamp: "1345", recording: nil, username_to: "test_2"),
            Message(id: 2, username_from: "test_2", timestamp: "1345", recording: nil, username_to: "test_1"),
            Message(id: 3, username_from: "test_1", timestamp: "1345", recording: nil, username_to: "test_2"),
            Message(id: 4, username_from: "test_1", timestamp: "1345", recording: nil, username_to: "test_2"),
            Message(id: 1, username_from: "test_1", timestamp: "1345", recording: nil, username_to: "test_3"),
            Message(id: 2, username_from: "test_2", timestamp: "1345", recording: nil, username_to: "test_3"),
            Message(id: 3, username_from: "test_3", timestamp: "1345", recording: nil, username_to: "test_2"),
            Message(id: 4, username_from: "test_3", timestamp: "1345", recording: nil, username_to: "test_4"),
            Message(id: 1, username_from: "test_3", timestamp: "1345", recording: nil, username_to: "test_1"),
            Message(id: 2, username_from: "test_2", timestamp: "1345", recording: nil, username_to: "test_3"),
            Message(id: 3, username_from: "test_2", timestamp: "1345", recording: nil, username_to: "test_1"),
            Message(id: 4, username_from: "test_1", timestamp: "1345", recording: nil, username_to: "test_3")]
        
        
        /*
         12 Total Messages
         
         Output for test_1
         test_2 = 5
         test_3 = 3
         test_4 = none
         
         Output for test_2
         test_1 = 5
         test_3 = 3
         test_4 = none
         
         Output for test_3
         test_1 = 3
         test_2 = 3
         test_4 = 1
         
         Output for test_4
         test_1 = none
         test_2 = none
         test_3 = 1
         
         */
        
        
        let playData = ContentViewHandler()
        let results = playData.filterAndGroupData(testData, currentUseID: "test_1")

        XCTAssertEqual(results.count, 2, "results count must be 2")
        XCTAssertEqual(results["test_2"]?.messages.count, 5, "test_1 and test_2 must be 5")
        XCTAssertEqual(results["test_3"]?.messages.count, 3, "test_1 and test_3 must be 3")
        
    }
}
