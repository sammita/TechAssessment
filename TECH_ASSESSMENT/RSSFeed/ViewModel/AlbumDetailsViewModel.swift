//
//  AlbumDetailsViewModel.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 13/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

/// View Model to update the Album details data in the ViewController

import UIKit

class AlbumDetailsViewModel: NSObject {
    //Shared instance to keep the selected Album info
    private var selectedAlbum = DataManager.shared.selectedAlbum
    //Image cache which holds the downloaded Album image
    private var imageCache = ImageCache.sharedImageCache
    
    init(album: Album? = DataManager.shared.selectedAlbum) {
        self.selectedAlbum = album
    }
    
    //Returns the album Image from Cache
    func getAlbumImage() -> UIImage? {
        guard let stringURL = selectedAlbum?.artworkUrl100 else { return nil }
        if let imageData = self.imageCache.getCachedImageDataFor(url: stringURL), let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    //Returns the album name of the selected Album
    func getAlbumName() -> String {
        return selectedAlbum?.name ?? ""
    }
    
    //Returns the Artist name of the selected Album
    func getArtistName() -> String {
        return selectedAlbum?.artistName ?? ""
    }
    
    //Returns the Genre name of the selected Album
    func getGenreName() -> String {
        let genres = AppConstants.genre + (selectedAlbum?.genres.map { "\($0.name)" }.joined(separator: ", ") ?? "")
        return genres
    }
    
    //Returns the Release date of the selected Album
    func getReleaseDate() -> String {
        return AppConstants.releaseDate + (selectedAlbum?.releaseDate ?? "")
    }
    
    //Returns the Copyright info of the selected Album
    func getCopyright() -> String {
        return selectedAlbum?.copyright ?? ""
    }
    
    //Returns the album URl of the selected Album
    func getAlbumURL() -> String {
        return selectedAlbum?.url ?? ""
    }
}
