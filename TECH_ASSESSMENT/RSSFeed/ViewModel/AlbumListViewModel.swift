//
//  AlbumListViewModel.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 12/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

/// View Model to update the Album list data in the ViewController

import UIKit

class AlbumListViewModel: NSObject {

    private var albumFeed:AlbumFeed?
    private var imageCache = ImageCache.sharedImageCache
    //Netork manager initialization
    private var networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // Method to fetch the list of Albums , calling the Service API
    func fetchAlbums(completion: @escaping (_ error: String?)->()) {
        networkManager.fetchFeeds { (albumFeed, error) in
            guard let albumInfo = albumFeed else {
                completion(error ?? AppConstants.Messages.serviceError)
                return
            }
            self.albumFeed = albumInfo
            completion(nil)//Albums fetched successfully
        }
    }
    
    // Returns the number of Albums fetched
    func numberOfAlbums() -> Int {
        return albumFeed?.feed.results.count ?? 0
    }
    
    //Returns the album information at the index
    /// - Parameter index: index of the album to fetch
    func albumInfoAtIndex(index: Int) -> (albumName:String?, artistName: String?) {
        let albumInfo = albumFeed?.feed.results[index]
        return (albumInfo?.name, albumInfo?.artistName)
    }
    
    //Returns the album image at the index, this method will return the image from cache if it is present there or else initiate the download process
    /// - Parameter index: index of the album to fetch, completion: callback which returns the image and index
    func fetchAlbumImage(forIndex index: Int, completion: @escaping(_ index: Int, _ image: UIImage?) -> Void) {
        guard let stringURL = albumFeed?.feed.results[index].artworkUrl100 else { return }
        //Check whether image is available in chache
        if let imageData = self.imageCache.getCachedImageDataFor(url: stringURL), let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                completion(index, image)
            }
        } else {
            downloadAlbumImage(forIndex: index, completion: completion)
        }
    }
    
    //Set the selected album information to a shared Datamanager class to accaess later on details page
    /// - Parameter index: index of the album
    func setSelectedAlbum(at index:Int){
        let albumInfo = albumFeed?.feed.results[index]
        DataManager.shared.selectedAlbum = albumInfo
    }
    
    //Method which initiates the image download process
    /// - Parameter index: index of the album, completion: callback which returns the image and index
    private func downloadAlbumImage(forIndex index: Int, completion: @escaping(_ index: Int, _ image: UIImage?) -> Void) {
        guard let stringURL = albumFeed?.feed.results[index].artworkUrl100 else { return }
        networkManager.fetchImage(imageUrl: stringURL) { [weak self] (data, error) in
                guard let imageData = data, let image = UIImage(data: imageData) else {
                return
            }
            self?.imageCache.saveImageDataToCache(imageData: imageData, url: stringURL)
            DispatchQueue.main.async {
                completion(index, image)
            }
        }
    }
}

