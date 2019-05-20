//
//  DetailViewController.swift
//  Project1
//
//  Created by Maksim Nosov on 19/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var allPictures: Int?
    var selectedIndexOfPictures: Int?
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
//        title = selectedImage
        if let selectedIndexOfPictures = selectedIndexOfPictures,
            let allPictures = allPictures {
            title = "Picture \(selectedIndexOfPictures + 1) of \(allPictures)"
        }
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
