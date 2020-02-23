//
//  AlbumDetailsViewModelTests.swift
//  RSSFeedTests
//
//  Created by Rajesh Sammita on 16/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

import XCTest
@testable import RSSFeed

class AlbumDetailsViewModelTests: XCTestCase {
    var albumDetailsViewModel: AlbumDetailsViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockAlbum = Album(artistName: "A Boogie wit da Hoodie",
                              id: "1498673868",
                              releaseDate: "2020-02-14",
                              name: "Artist 2.0",
                              copyright: "℗ 2020 Atlantic Recording Corporation and Highbridge The Label, LLC.",
                              artistId: "1068300376",
                              artistUrl: "https://music.apple.com/us/artist/a-boogie-wit-da-hoodie/1068300376?app=music",
                              artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/92/0d/1c/920d1c7f-4085-b286-b33e-d0c022bf9f55/075679823359.jpg/200x200bb.png",
                              genres: [Genre(genreId: "18",
                                             name: "Hip-Hop/Rap",
                                             url: "https://itunes.apple.com/us/genre/id18")],
                              url: "https://music.apple.com/us/album/artist-2-0/1498673868?app=music")
        albumDetailsViewModel = AlbumDetailsViewModel(album: mockAlbum)
    }
    
    func test_getAlbumName() {
        XCTAssertTrue(albumDetailsViewModel?.getAlbumName() == "Artist 2.0")
    }
    
    func test_getArtistName() {
        XCTAssertTrue(albumDetailsViewModel?.getArtistName() == "A Boogie wit da Hoodie")
    }
    
    func test_getGenreName() {
        let expectedGenres = AppConstants.genre + "Hip-Hop/Rap"
        XCTAssertTrue(albumDetailsViewModel?.getGenreName() == expectedGenres)
    }
    
    func test_getReleaseDate() {
        let expectedReleaseDate = AppConstants.releaseDate + "2020-02-14"
        XCTAssertTrue(albumDetailsViewModel?.getReleaseDate() == expectedReleaseDate)
    }
    
    func test_getCopyright() {
        XCTAssertTrue(albumDetailsViewModel?.getCopyright() == "℗ 2020 Atlantic Recording Corporation and Highbridge The Label, LLC.")
    }
    
    func getAlbumURL() {
        XCTAssertTrue(albumDetailsViewModel?.getAlbumURL() == "https://music.apple.com/us/album/artist-2-0/1498673868?app=music")
    }
}
