//
//  MockURLSession.swift
//  RSSFeedTests
//
//  Created by Sreelal Hamsavahanan on 15/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {

    private var response: URLResponse?
    private var data: Data?
    private var error: Error?
    public static let sharedInstance = MockURLSession()
    
    override init() {
        //Empty init implementation to avid iOS 13 deprecated warning while initializing MockURLSession
    }
    
    func shouldReturnData(_ data: Data, for url: URL?) {
        if let mockURL = url {
            self.response = HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        }
        self.data = data
    }

    func shouldReturnError(_ error: Error, for url: URL?) {
        if let mockURL = URL(string: "") {
            self.response = HTTPURLResponse(url: mockURL, statusCode: 500, httpVersion: nil, headerFields: nil)
        }
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {

    private let closure: () -> Void

    init(_ closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
