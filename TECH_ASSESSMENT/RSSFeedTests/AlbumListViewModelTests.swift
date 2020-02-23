//
//  AlbumListViewModelTests.swift
//  RSSFeedTests
//
//  Created by Rajesh Sammita on 16/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

import XCTest
@testable import RSSFeed

class AlbumListViewModelTests: XCTestCase {
    
    let session = MockURLSession.sharedInstance
    var networkManager: NetworkManager?
    var albumListViewModel: AlbumListViewModel?
    
    override func setUp() {
        networkManager = NetworkManager(session: session)
        // Now setup the model objecty with all mock data
        if let manager = networkManager {
            albumListViewModel = AlbumListViewModel(networkManager: manager)
        }
        loadMockData()
    }
    
    //To preconfigure the network manager class to return the mock data fo albums
    /// - Parameter index: index of the album to fetch
    func loadMockData() {
        //Setup the mock Album data
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "MockAlbums", withExtension: "json") else { return }
        var expectedData: Data = Data()
        do {
            expectedData = try Data(contentsOf: url,options: .alwaysMapped)
        } catch {
            return
        }
        session.shouldReturnData(expectedData, for: URL(string: "http://mockurl.com"))
    }
    
    func test_fetchAlbums() {
        albumListViewModel?.fetchAlbums(completion: { (error) in
            XCTAssertTrue(error == nil)
        })
    }
    
    func test_numberOfAlbums() {
        albumListViewModel?.fetchAlbums(completion: {[weak self] (error) in
            guard let strongSelf = self else { return }
            let count = strongSelf.albumListViewModel?.numberOfAlbums()
            XCTAssertTrue(count == 1)
        })
    }
    
    func test_albumInfoAtIndex() {
        albumListViewModel?.fetchAlbums(completion: {[weak self] (error) in
            guard let strongSelf = self else { return }
            let album = strongSelf.albumListViewModel?.albumInfoAtIndex(index: 0)
            XCTAssertTrue(album?.artistName == "A Boogie wit da Hoodie")
        })
    }
    
    func test_setSelectedAlbum() {
        albumListViewModel?.fetchAlbums(completion: {[weak self] (error) in
            guard let strongSelf = self else { return }
            strongSelf.albumListViewModel?.setSelectedAlbum(at: 0)
            let albumExpected = strongSelf.albumListViewModel?.albumInfoAtIndex(index: 0)
            XCTAssertTrue(DataManager.shared.selectedAlbum?.artistName == albumExpected?.artistName)

        })
    }
    
}
