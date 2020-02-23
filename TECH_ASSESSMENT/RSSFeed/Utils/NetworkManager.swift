//
//  NetworkManager.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 12/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

//Manager Class to handle all the network calls in the app
import UIKit

class NetworkManager: NSObject {
    
    var urlSessionDownloadTasks : [URLSessionDataTask] = []
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    //Method which calls the API to fetch RSS Feeds
    ///- Parameter completion: feedResponse as AlbumFeed model Object which has all the album details,error: error descriotion , in case of any error in response.This will be nil if no error is there
    func fetchFeeds(completion: @escaping (_ feedResponse: AlbumFeed?,_ error: String?)->()) {
        guard let url = URL(string: AppConstants.feedURL) else {return}
        let task = self.session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                //Error in response
                completion(nil, error?.localizedDescription)
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    //Response is success
                    guard let responseData = data else {
                        completion(nil, AppConstants.Messages.serviceError)
                        return
                    }
                    do {
                        let rssFeedResponse = try JSONDecoder().decode(AlbumFeed.self, from: responseData)
                        completion(rssFeedResponse, error?.localizedDescription)
                    } catch {
                        print(error)
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    //Error in response
                    completion(nil, AppConstants.Messages.serviceError)
                }
            }
        })
        task.resume()
    }
    
    //Method which downloads the Album image
    ///- Parameter imageUrl: url of the image to download completion: imageData, which is the downloaded image as Data,error: error description , in case of any error in response.This will be nil if no error is there
    func fetchImage(imageUrl: String, completion: @escaping (_ imageData: Data?, _ error: String?)->()) {
        
        guard let url = URL(string: imageUrl) else {
            //Invalid URL
            completion(nil, AppConstants.Messages.serviceError)
            return
        }
        guard urlSessionDownloadTasks.firstIndex(where: { $0.originalRequest?.url == url }) == nil else {
            // Image Download is in progress
            return
        }
        let dataTask = self.session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, error as? String)
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    //Download success
                    guard let responseData = data else {
                        completion(nil, AppConstants.Messages.serviceError)
                        return
                    }
                    completion(responseData, nil)
                }
            } else {
                completion(nil, AppConstants.Messages.serviceError)
            }
        }
        dataTask.resume()
        urlSessionDownloadTasks.append(dataTask)
    }
}
