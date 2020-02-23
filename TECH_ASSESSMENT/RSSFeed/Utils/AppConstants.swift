//
//  AppConstants.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 12/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

//Constants Class which keeps all the constants on the app
import UIKit

class AppConstants: NSObject {
    static let alertTitle = "iTunes Feed"
    static let buttonTitle = "View Album"
    static let releaseDate = "Release-Date: "
    static let genre = "Genre: "
    static let artist = "Artist: "
    static let album = "Album: "
    static let feedURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    struct Messages {
        static let serviceError = "Unexpected error occured.Please try again"
    }
}
