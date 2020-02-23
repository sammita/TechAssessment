//
//  BaseViewController.swift
//  RSSFeed
//
//  Created by Sreelal Hamsavahanan on 13/02/20.
//  Copyright © 2020 Tech. All rights reserved.
//

//ViewController Base Class which implement all the common methods helpful for all the view controllers.

import UIKit

class BaseViewController: UIViewController {
    
    private var activityIndicatorView: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Shows a busy indicator (ActivityIndicator) at the middle of the screen
    func showBusyIndicator() {
        if let activityView = activityIndicatorView {
            activityView.removeFromSuperview()
        }
        let activityView = UIActivityIndicatorView(style: .large)
        activityIndicatorView = activityView
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.isHidden = false
        activityView.startAnimating()
        view.addSubview(activityView)
        view.isUserInteractionEnabled = false
        //Add the constraints for the tableview, activity indicator View
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //Hides the busy indicator (ActivityIndicator) at the middle of the screen
    func hideBusyIndicator() {
        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.removeFromSuperview()
        activityIndicatorView = nil
        view.isUserInteractionEnabled = true
    }
    
    //Method to show an alert message
    ///- Parameter message: message to show on alert
    func showAlert(message:String) {
        let alert = UIAlertController(title: AppConstants.alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
