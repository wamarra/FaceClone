//
//  PhotoCollectionViewCell.swift
//  FaceClone
//
//  Created by Wesley Marra on 02/10/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setup(with url: URL) {
        activityIndicator.startAnimating()
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
