//
//  ViewController.swift
//  Project31
//
//  Created by Maksim Nosov on 28/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var emptyStackViewLabel: UILabel!
    
    weak var activeWebView: WKWebView?
    var defaultURL = "https://www.hackingwithswift.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyStackViewLabel.isHidden = true

        setDefaultTitle()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWebView))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteWebView))
        navigationItem.rightBarButtonItems = [delete, add]
        
    }
    
    func setDefaultTitle() {
        title = "Multibrowser"
        emptyStackViewLabel.isHidden = false
        emptyStackViewLabel.text = "Input address in bar or tap on PLUS icon."
        addressBar.text = ""
    }
    
    @objc func addWebView() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        emptyStackViewLabel.isHidden = true
        
        stackView.addArrangedSubview(webView)
        var urlString = defaultURL
        
        if let url = addressBar.text, !url.isEmpty {
            urlString = addressBar.text!
        }
        
        print(urlString)
        
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
        
        webView.layer.borderColor = UIColor.blue.cgColor
        selectWebView(webView)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
    }
    
    func selectWebView(_ webView: WKWebView) {
        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        
        activeWebView = webView
        webView.layer.borderWidth = 3
        updateUI(for: webView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if stackView.arrangedSubviews.count == 0 {
            if isAddressFieldValid(addressBar) {
                addWebView()
            }
        } else {
            if isAddressFieldValid(addressBar) {
                if let webView = activeWebView {
                    if let url = URL(string: addressBar.text!) {
                        webView.load(URLRequest(url: url))
                    }
                }
            }
            
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func isAddressFieldValid(_ address: UITextField) -> Bool {
        if let address = addressBar.text, ( address.hasPrefix("http://")) || (address.hasPrefix("https://") ) {
            return true
        } else {
            let ac = UIAlertController(title: "Error", message: "URL must contains https:// or http:// in address.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return false
        }
    }
    
    @objc func webViewTapped(_ recognizer: UITapGestureRecognizer) {
        if let selectedWebView = recognizer.view as? WKWebView {
            selectWebView(selectedWebView)
        }
    }
    
    @objc func deleteWebView() {
        // safely unwrap our webview
        if let webView = activeWebView {
            if let index = stackView.arrangedSubviews.firstIndex(of: webView) {
                // we found the current webview in the stack view! Remove it from the stack view
                stackView.removeArrangedSubview(webView)
                
                // now remove it from the view hierarchy – this is important!
                webView.removeFromSuperview()
                
                if stackView.arrangedSubviews.count == 0 {
                    // go back to our default UI
                    setDefaultTitle()
                } else {
                    // convert the Index value into an integer
                    var currentIndex = Int(index)
                    
                    // if that was the last web view in the stack, go back one
                    if currentIndex == stackView.arrangedSubviews.count {
                        currentIndex = stackView.arrangedSubviews.count - 1
                    }
                    
                    // find the web view at the new index and select it
                    if let newSelectedWebView = stackView.arrangedSubviews[currentIndex] as? WKWebView {
                        selectWebView(newSelectedWebView)
                    }
                }
            }
        }
    }
    
    func updateUI(for webView: WKWebView) {
        title = webView.title
        addressBar.text = webView.url?.absoluteString ?? ""
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.horizontalSizeClass == .compact {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView == activeWebView {
            updateUI(for: webView)
        }
    }
}

