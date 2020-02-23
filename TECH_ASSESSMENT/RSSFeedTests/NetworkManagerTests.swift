//
//  NetworkManagerTests.swift
//  RSSFeedTests
//
//  Created by Rajesh Sammita on 15/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

import XCTest
@testable import RSSFeed

class NetworkManagerTests: XCTestCase {
    
    let session = MockURLSession.sharedInstance
    var networkManager: NetworkManager?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager(session: session)
    }
    
    func test_return_actual_data() {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "MockAlbums", withExtension: "json") else { return }
        var expectedData: Data = Data()
        do {
            expectedData = try Data(contentsOf: url,options: .alwaysMapped)
        } catch {
            return
        }
        session.shouldReturnData(expectedData, for: URL(string: "http://mockurl.com"))
        networkManager?.fetchFeeds { (album, error) in
            if let albumReceived = album {
                XCTAssertEqual(albumReceived.feed.results[0].artistId, "1068300376")
            } else {
                XCTAssertFalse(true)
            }
        }
    }
    
    func test_return_error_data() {
        let expectedErrorDescription = "Mock Error"
        let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorDescription])
        session.shouldReturnError(customError, for: URL(string: "http://mockurl.com"))
        networkManager?.fetchFeeds { (album, error) in
            if let errorReceived = error {
                XCTAssertEqual(errorReceived, expectedErrorDescription)
            } else {
                XCTAssertFalse(true)
            }
        }
    }
    
    
}
