//
//  DataManager.swift
//  RSSFeed
//
//  Created by Sreelal Hamsavahanan on 13/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

//Class which holds all the shared data on the app

import UIKit

class DataManager: NSObject {
    public static let shared = DataManager()
    //Selected album in AlbumListViewcontroller , which needs to be accessed from AlbumDetailsViewcontroller to display details
    var selectedAlbum: Album?
}
