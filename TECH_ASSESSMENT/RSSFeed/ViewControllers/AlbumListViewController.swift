//
//  AlbumListViewController.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 12/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

//ViewController which lists all the Top Albums

import UIKit

class AlbumListViewController: BaseViewController {
    
    var tableView: UITableView?
    var albumListViewModel: AlbumListViewModel = AlbumListViewModel()
    let backgroundQueue = DispatchQueue.global() //Using to perform image setting operations in cell, using this to avoid flickering while scroll
    let mainQueue = DispatchQueue.main// Main queue to perform UI related operations
    
    //Constants on the Viewcontroller
    private struct Constants {
        static let cellIdentifier = "imageCell"
        static let cellSpacing = 5.0
        static let cellHeight = 150.0
        static let title = "Top 100 Albums"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        //Load Albums
        albumListViewModel.fetchAlbums {[weak self] (error) in
            guard let strongSelf = self else { return }
            //Moving to main queue to update UI
            strongSelf.mainQueue.async {
                strongSelf.hideBusyIndicator()
                if let errorMessage = error {
                    //Received an error respoinse
                    strongSelf.showAlert(message: errorMessage)
                } else {
                    //Reload table view with Album info
                    strongSelf.tableView?.reloadData()
                }
            }
        }
        self.showBusyIndicator()
    }
    
    // Initialize and preconfigure all the views
    
    func configureView() {
        self.title = Constants.title
        //Add table view
        let feedsTableView = UITableView(frame: self.view.bounds, style: .insetGrouped)
        tableView = feedsTableView
        self.view.addSubview(feedsTableView)
        feedsTableView.dataSource = self
        feedsTableView.delegate = self
        feedsTableView.backgroundColor = .white
        feedsTableView.separatorStyle = .singleLine
    }
}

// MARK: - TableView Datasource methods

extension AlbumListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumListViewModel.numberOfAlbums()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.cellIdentifier)
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.numberOfLines = 0
            cell?.selectionStyle = .none
        }
        let albumInfo = albumListViewModel.albumInfoAtIndex(index: indexPath.section)
        cell?.tag = indexPath.section
        cell?.imageView?.image = nil
        //Trying to fetch the image in a background queue, to avoid flickering while scroll
        backgroundQueue.async {
            self.albumListViewModel.fetchAlbumImage(forIndex: indexPath.section) {[weak self] (index, image) in
                guard let strongSelf = self else { return }
                let selectedIndexPath = IndexPath(row: 0, section: index)
                if let updateCell = tableView.cellForRow(at: selectedIndexPath) {
                    //Setting image on the cell in main queue
                    strongSelf.mainQueue.async {
                        updateCell.imageView?.image = image
                        updateCell.setNeedsLayout()
                    }
                }
            }
        }
        cell?.textLabel?.text = albumInfo.albumName
        cell?.detailTextLabel?.text = albumInfo.artistName
        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate methods

extension AlbumListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.albumListViewModel.setSelectedAlbum(at: indexPath.section)
        let albumDetailsVC = AlbumDetailsViewController()
        self.navigationController?.pushViewController(albumDetailsVC, animated: true)
    }
}

