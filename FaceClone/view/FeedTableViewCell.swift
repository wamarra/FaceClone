//
//  FeedTableViewCell.swift
//  FaceClone
//
//  Created by Wesley Marra on 24/09/21.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static let kReuseIdentifier = "FeedTableViewCell"
    
    private var userId: Int!

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var givenName: UILabel!
    
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var postText: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var likes: UILabel!
    
    @IBOutlet weak var comments: UILabel!
    
    static func register(in tableview: UITableView) {
        let xib = UINib(nibName: "FeedTableViewCell", bundle: Bundle.main)
        tableview.register(xib, forCellReuseIdentifier: kReuseIdentifier)
    }
    
    func setup(with user: User?, post: Post?) {
        let date = Date().timeIntervalSince1970
        profilePicture.image = UIImage(data: try! Data(contentsOf: URL(string: "http://lorempixel.com.br/100/100?\(date)")!))
        givenName.text = user?.name
        postDate.text = "Sexta-feira, 24 de Set de 2021 às 21:15"
        postText.text = post?.body
        postImage.image = UIImage(data: try! Data(contentsOf: URL(string: "http://lorempixel.com.br/600/450?\(date+1)")!))
        likes.text = "150 likes"
        comments.text = "32 Commentários"
        userId = user?.id
    }
    
    @IBAction func onPostOptions(_ sender: UIButton) {
        
    }
    
    @IBAction func onLike(_ sender: UIButton) {
        
    }
    
    @IBAction func onComment(_ sender: UIButton) {
        
    }
    
    
    @IBAction func onShare(_ sender: UIButton) {
        
    }
    
}
