//
//  UIViewControllerExtension.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import Foundation
import UIKit

extension UIViewController {
    func addEmptyView(title : String, description : String, insets : UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), backgroundColor : UIColor? = nil) {
        let emptyView = EmptyView.instanceFromNib()
        emptyView.configure(title: title, description: description)
        view.addSubview(emptyView)
        let metrics = ["top" : insets.top, "bottom" : insets.bottom, "right" : insets.right, "left" : insets.left]
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[emptyView]-(right)-|", options: [], metrics: metrics, views: ["emptyView" : emptyView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[emptyView]-(bottom)-|", options: [], metrics: metrics, views: ["emptyView" : emptyView]))
    }
    
    func showHideEmptyView(isHide : Bool) {
        let emptyArray = view.subviews.filter({$0 is EmptyView})
        if let emptyView = emptyArray.first{
            emptyView.isHidden = isHide
        }
    }
}
