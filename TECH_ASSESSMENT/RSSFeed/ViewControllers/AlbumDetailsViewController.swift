//
//  AlbumDetailsViewController.swift
//  RSSFeed
//
//  Created by Rajesh Sammita on 13/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

//ViewController which shows the details of album selected in AlbumListViewcontroller

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    private var albumDetailsViewModel = AlbumDetailsViewModel()
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    // Initialize and preconfigure all the views
    
    func configureView() {
        let inset = CGFloat(10)
        let musicButtonInset = CGFloat(20)
        let musicButtonHeight = CGFloat(40)
        self.view.backgroundColor = UIColor.white
        self.title = albumDetailsViewModel.getAlbumName()

        // Add image view
        let albumImageView = UIImageView()
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.contentMode = .scaleAspectFit
        albumImageView.image = albumDetailsViewModel.getAlbumImage()

        //Add Album descriotuon stackView
        let albumDescriptionStack = UIStackView(frame: self.view.bounds)
        albumDescriptionStack.alignment = .fill
        albumDescriptionStack.spacing = 10
        albumDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
        albumDescriptionStack.axis = .vertical
        albumDescriptionStack.distribution = .fillProportionally
        
        //Add Album Name label
        let albumNameLabel = UILabel()
        albumNameLabel.text = albumDetailsViewModel.getAlbumName()
        albumNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        setLabelProperties(label: albumNameLabel)
        
        //Add Artist Name label
        let artistNameLabel = UILabel()
        artistNameLabel.text = albumDetailsViewModel.getArtistName()
        artistNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        setLabelProperties(label: artistNameLabel)
        
        //Add Genre Name label
        let genreNameLabel = UILabel()
        genreNameLabel.text = albumDetailsViewModel.getGenreName()
        genreNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        setLabelProperties(label: genreNameLabel)
        
        //Add Release Date Name label
        let releaseDateNameLabel = UILabel()
        releaseDateNameLabel.text = albumDetailsViewModel.getReleaseDate()
        releaseDateNameLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        setLabelProperties(label: releaseDateNameLabel)
        
        //Add Copyright Name label
        let copyrightNameLabel = UILabel()
        copyrightNameLabel.text = albumDetailsViewModel.getCopyright()
        copyrightNameLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        setLabelProperties(label: copyrightNameLabel)
        
        albumDescriptionStack.addArrangedSubview(albumNameLabel)
        albumDescriptionStack.addArrangedSubview(artistNameLabel)
        albumDescriptionStack.addArrangedSubview(genreNameLabel)
        albumDescriptionStack.addArrangedSubview(releaseDateNameLabel)
        albumDescriptionStack.addArrangedSubview(releaseDateNameLabel)
        albumDescriptionStack.addArrangedSubview(copyrightNameLabel)

        //Add Music button
        let musicButton = UIButton(type: .custom)
        musicButton.backgroundColor = UIColor.red
        musicButton.translatesAutoresizingMaskIntoConstraints = false
        musicButton.setTitle(AppConstants.buttonTitle, for: .normal)
        musicButton.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)

        //Adding all the Views
        self.view.addSubview(albumImageView)
        self.view.addSubview(albumDescriptionStack)
        self.view.addSubview(musicButton)
        
        //set up the constraints for the Parent StackView & naviate to music button
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            albumImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            albumImageView.bottomAnchor.constraint(equalTo: albumDescriptionStack.safeAreaLayoutGuide.topAnchor, constant: -inset),
            
            albumDescriptionStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            albumDescriptionStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            albumDescriptionStack.bottomAnchor.constraint(equalTo: musicButton.safeAreaLayoutGuide.topAnchor, constant: -musicButtonInset),
            
            musicButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: musicButtonInset),
            musicButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -musicButtonInset),
            musicButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -musicButtonInset),
            musicButton.heightAnchor.constraint(equalToConstant: musicButtonHeight)
        ])
        self.view.layoutIfNeeded()
    }
    
    // To set the default properties of labels in the view
    ///- Parameter label: label to modify
    func setLabelProperties(label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
    }
    
    // To open the selected Album
    ///- Parameter sender: Instance of the button selected
    @objc func openAlbum(sender: UIButton!) {
        if let url = URL(string: albumDetailsViewModel.getAlbumURL()) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
