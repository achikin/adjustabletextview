//
//  ViewController.swift
//  AdjustableTextView
//
//  Created by Anton Chikin on 5/12/16.
//  Copyright © 2016 chikin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView?
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTextView() {
        if let txtView = textView {
            txtView.scrollsToTop = false;
            txtView.backgroundColor = UIColor.redColor();
            txtView.scrollEnabled = true;
            txtView.addObserver(self, forKeyPath: "contentSize", options:[ NSKeyValueObservingOptions.Old , NSKeyValueObservingOptions.New], context: nil)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
        if let changeDict = change, constraint = textViewHeightConstraint, view = self.textView {
            if object as? NSObject == self.textView && keyPath == "contentSize" {
                if let oldContentSize = changeDict[NSKeyValueChangeOldKey]?.CGSizeValue(),
                    newContentSize = changeDict[NSKeyValueChangeNewKey]?.CGSizeValue() {
                    
                    let dy = newContentSize.height - oldContentSize.height
                    constraint.constant = constraint.constant + dy;
                    self.view.layoutIfNeeded()
                    let contentOffsetToShowLastLine = CGPointMake(0.0, view.contentSize.height - CGRectGetHeight(view.bounds))
                    view.contentOffset = contentOffsetToShowLastLine
                }
            }
        }
    }

}

