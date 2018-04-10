//
//  ChannelsListViewController.swift
//  ChannelsCodingChallenge
//
//  Created by Vamsi Chebolu on 4/8/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import UIKit

class ChannelsListViewController: UIViewController {

    private var listIdentifier = "channelListIdentifier"
    private var channelList = [Channel]()
    private var filterdChannels = [Channel]()
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Channels List"
        // Configure table View
        tableView.register(UINib(nibName:"ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: listIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // SetUp the search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by DJ"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.loadData()
    }
    
    private func loadData() {
        guard let url = ChannelsNetworking.channelsAPIURL() else { return }
        let conf = BackendConfiguration(baseURL: url)
        let channelRequest = ChannelsGETRequest()
        let channelsInteractor = ChannelsListInteractor(backEndService: SessionManager(conf))
        channelsInteractor.getListOfChannelsWith(request: channelRequest) { [weak self] (channels, errorType) in
            guard let parsedChannels = channels else {
                self?.present(ChannelsListViewController.alertController(for: (errorType?.getAlertMessage() ?? "")), animated: true, completion: nil)
                return
            }
            self?.channelList = parsedChannels
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
    }
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterdChannels = channelList.filter({( channel : Channel) -> Bool in
            return channel.dj.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ChannelDetailViewController, let selectedRow = tableView.indexPathForSelectedRow?.row {
            let channel: Channel
            if isFiltering() {
                channel = filterdChannels[selectedRow]
            } else {
                channel = channelList[selectedRow]
            }
            destinationVC.channel = channel
        }
    }
}

extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterdChannels.count
        }
        return channelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listIdentifier, for: indexPath) as? ChannelTableViewCell else { fatalError() }
        cell.selectionStyle = .none
        let channel: Channel
        if isFiltering() {
            channel = filterdChannels[indexPath.row]
        } else {
            channel = channelList[indexPath.row]
        }
        cell.title.text = "Title: \(channel.title)"
        cell.detail.text = "Description: \(channel.description)"
        cell.dj.text = "Dj: \(channel.dj)"
        /* For this challenge I am not doing prefecthing images using UITableViewDataSourcePrefetching delegates */
        cell.channelImageView.loadImageUsingUrlString(urlString: channel.thumbnailImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

extension ChannelsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}



