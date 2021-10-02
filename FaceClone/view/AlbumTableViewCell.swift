//
//  AlbumTableViewCell.swift
//  FaceClone
//
//  Created by Wesley Marra on 01/10/21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    static let kReuseIdentifier = "AlbumTableViewCell"
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    static func register(in tableview: UITableView) {
        let xib = UINib(nibName: "AlbumTableViewCell", bundle: Bundle.main)
        tableview.register(xib, forCellReuseIdentifier: kReuseIdentifier)
    }

    func setup(with album: Album?) {
        title.text = album?.title
        date.text = "Sexta-feira, 24 de Set de 2021 às 21:15"
    }
}
