//
//  AlbumTableViewController.swift
//  FaceClone
//
//  Created by Wesley Marra on 01/10/21.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    
    let SeguePhotosViewController = "PhotosCollectionView"
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"
    
    private var count = 10
    
    var user: User!
    
    private var albums = [Album]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlbumTableViewCell.register(in: tableView)
        
        getData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SeguePhotosViewController, sender: self)
            
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SeguePhotosViewController {
            if let indexPath = tableView.indexPathForSelectedRow, let album = albums[indexPath.row] as AnyObject? {
                let destinationViewController = segue.destination as! PhotoCollectionViewController
                destinationViewController.album = album as? Album
            }
        }
    }
    
    private func getData() {
        if let url = URL(string: "\(kBaseURL)/users/\(user.id)/albums") {
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: self,
                delegateQueue: OperationQueue.main)
            
            session.dataTask(with: url).resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.kReuseIdentifier, for: indexPath) as! AlbumTableViewCell
        
        cell.setup(with: albums[indexPath.row])
        
        return cell
    }
}

extension AlbumTableViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let response = dataTask.response as? HTTPURLResponse,
           response.statusCode >= 200, response.statusCode < 300 {
            
            if let albums = try? JSONDecoder().decode([Album].self, from: data) {
                self.albums = albums
            }
        }
    }
}

