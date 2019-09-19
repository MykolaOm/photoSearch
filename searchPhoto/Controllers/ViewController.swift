//
//  ViewController.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/13/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController, UISearchBarDelegate {
    let realm = try! Realm()
    lazy var searchBar: PhotoSearchBar = PhotoSearchBar()
    lazy var activityIndicator: PhotoActivityIndicator = PhotoActivityIndicator()
    let cellId = "cellId"
    let realmHelper = RealmHelper.shared
    private let cashe = ImageCache()
    private let network = NetworkService.shared
    lazy var searchHistory: Results<SearchHistory> = {
        self.realm.objects(SearchHistory.self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        getDataFromRealm()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isHistoryNotEmpty() ? searchHistory.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = searchHistory[indexPath.row].searchString
        cell.imageView?.image = UIImage(data: searchHistory[indexPath.row].searchedImage!)
        return cell
    }

    private func getDataFromRealm(){
        if isHistoryNotEmpty() {
            reloadViews()
        }
    }
    
    private func reloadViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setUpSubViews(){
        setUpCells()
        setUpSearchBar()
        setUpActivityIndicator()
        setUpTableView()
    }
    
    private func isHistoryNotEmpty() -> Bool {
        return searchHistory.count > 0
    }
    
    private func setUpActivityIndicator(){
        self.activityIndicator.configure(center:self.view.center)
        self.view.addSubview(activityIndicator)
    }
    
    private func setUpTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setUpCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
    }
    
    private func setUpSearchBar(){
        searchBar.configure()
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:searchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text else { return }
        if isUnique (query: query) {
            activityIndicator.startAnimating()
            startRequestFor(query: query)
        }
    }
    
    private func startRequestFor(query:String) {
        if let url = network.getUrlWith(param: query, urlString: Unsplash.link) {
            network.getRequest(to: url, completion: { message, url in
                if let imgUrl = url {
                        let image = self.cashe.getImage(url: imgUrl)
                        if image != nil {
                            self.realmHelper.addItemToRealm(str: query, url: imgUrl, data: Data((image?.pngData())!))
                        }
                } else {
                    let delay = DispatchTime.now() + 2.0
                    self.showAlertFor(delay: delay, message: message)
                }
                DispatchQueue.main.async {
                    self.reloadViews()
                    self.activityIndicator.stopAnimating()
                }
            })
        }
    }

    private func showAlertFor(delay:DispatchTime, message: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Search issue", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert,animated: true)
            DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                alert.dismiss(animated: true)
            })
        }
    }
    private func isUnique(query:String) -> Bool {
        var result = false
        if !query.isEmpty {
            let occurances = searchHistory.filter{$0.searchString.lowercased() == query.lowercased()}
            if occurances.count == 0 {
                result = true
            }
        }
        return result
    }
}

