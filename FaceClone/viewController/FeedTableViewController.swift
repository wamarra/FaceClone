//
//  FeedTableViewController.swift
//  FaceClone
//
//  Created by Wesley Marra on 24/09/21.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    let SegueAlbumsViewController = "AlbumsViewController"
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private var count = 10
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData(from: "users")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedTableViewCell.register(in: tableView)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func onRefresh(_ sender: UIRefreshControl) {
       count += 5
        
        tableView.reloadSections([0], with: .automatic)
        
        getData(from: "users")
        
        sender.endRefreshing()
    }
    
    private func getData(from type: String) {
        if let url = URL(string: "\(kBaseURL)/\(type)") {
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: self,
                delegateQueue: OperationQueue.main)
            
            session.dataTask(with: url).resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.kReuseIdentifier, for: indexPath) as! FeedTableViewCell
        
        var user: User?
        if (!users.isEmpty) {
            user = users[indexPath.row]
        }
        
        var post: Post?
        if (!posts.isEmpty) {
            post = posts[indexPath.row]
        }
        
        cell.setup(with: user, post: post)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueAlbumsViewController, sender: self)
            
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueAlbumsViewController {
            if let indexPath = tableView.indexPathForSelectedRow, let user = users[indexPath.row] as AnyObject? {
                let destinationViewController = segue.destination as! AlbumTableViewController
                destinationViewController.user = user as? User
            }
        }
    }
}

extension FeedTableViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200, response.statusCode < 300 {
            
            if let users = try? JSONDecoder().decode([User].self, from: data) {
                for user in users {
                    getData(from: "users/\(user.id)/posts")
                }
                self.users = users
            } else {
                if let posts = try? JSONDecoder().decode([Post].self, from: data) {
                    self.posts = posts
                }
            }
        }
    }
}
