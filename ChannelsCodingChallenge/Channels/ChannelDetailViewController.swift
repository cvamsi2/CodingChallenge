//
//  ChannelDetailViewController.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import Foundation
import UIKit

class ChannelDetailViewController: UIViewController {
    private enum DetailViewDataSourceTypes {
        case largeImage, title, dj, djmail, listeners, genre
    }
    @IBOutlet weak var tableView: UITableView!
    private var cellIdentifier = "channelLargerImageIdentifier"
    var channel: Channel?
    private var dataSource = [DetailViewDataSourceTypes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Details"
        // Set up data source
        dataSource = [.largeImage, .title, .dj, .djmail, .listeners, .genre]
        // Configure table View
        tableView.register(UINib(nibName:"ChannelLargeImageTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
}

extension ChannelDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (channel == nil ? 0 : dataSource.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .largeImage:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChannelLargeImageTableViewCell else {
                fatalError()
            }
            cell.channelImage.loadImageUsingUrlString(urlString: channel?.extraLargeImageURL ?? "")
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellIdentifier", for: indexPath)
            cell.textLabel?.text = "Titile: \(channel?.title ?? "")"
            return cell
        case .dj:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellIdentifier", for: indexPath)
            cell.textLabel?.text = "DJ: \(channel?.dj ?? "")"
            return cell
        case .djmail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellIdentifier", for: indexPath)
            cell.textLabel?.text = "DJMail: \(channel?.djmail ?? "")"
            return cell
        case .listeners:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellIdentifier", for: indexPath)
            cell.textLabel?.text = "Listeners: \(channel?.listeners ?? "")"
            return cell
        case .genre:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellIdentifier", for: indexPath)
            cell.textLabel?.text = "Genre: \(channel?.genre ?? "")"
            return cell
        }
    }
}
