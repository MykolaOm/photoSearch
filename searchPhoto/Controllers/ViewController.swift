//
//  ViewController.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/13/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UISearchBarDelegate {
    let realm = try! Realm()
    lazy var searchBar: PhotoSearchBar = PhotoSearchBar()
    lazy var activityIndicator: PhotoActivityIndicator = PhotoActivityIndicator()
    let realmHelper = RealmHelper.shared
    private let cashe = ImageCache()
    private let network = NetworkService.shared
    lazy var searchHistory: Results<SearchHistory> = {
        self.realm.objects(SearchHistory.self)
    }()
    var tableView: PhotoTable!
    var oldCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        updateDataSource()
    }
    func updateDataSource() {
        var dataSource = [StandartCell]()
        for index in oldCount..<self.searchHistory.count {
//            guard let image = UIImage(data: searchHistory[index].searchedImage!) else { return }
            guard let image = FileManagerHelper.read(fileName: searchHistory[index].searchString) else { return }
            let element = StandartCell(image: image, author: searchHistory[index].searchString)
            dataSource.append(element)
        }
        oldCount = oldCount + dataSource.count
        if !dataSource.isEmpty {
            tableView.customElements.append(contentsOf: dataSource)
        }
//        getDataFromRealm()
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
        setUpTableView()
        setUpSearchBar()
        setUpActivityIndicator()    }
    
    private func isHistoryNotEmpty() -> Bool {
        return searchHistory.count > 0
    }
    
    private func setUpActivityIndicator(){
        self.activityIndicator.configure(center:self.view.center)
        self.view.addSubview(activityIndicator)
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
    func setUpTableView() {
        tableView = PhotoTable()
        view.addSubview(tableView)
        tableView.setupTableView(cellType: CustomCellType.standart)
    }
    private func startRequestFor(query:String) {
        if let url = network.getUrlWith(param: query, urlString: Unsplash.link) {
            network.getRequest(to: url, completion: { message, url in
                if let imgUrl = url {
                        let image = self.cashe.getImage(url: imgUrl)
                        if image != nil {
                            let path = FileManagerHelper.write(fileName: query, image: image!)
                            self.realmHelper.addKeyandPathToRealm(str: query, path: String(describing: path))
// self.realmHelper.addItemToRealm(str: query, url: imgUrl,
//                            data: Data((image?.pngData())!))
                    }
                } else {
                    let delay = DispatchTime.now() + 2.0
                    self.showAlertFor(delay: delay, message: message)
                }
                DispatchQueue.main.async {
                    self.updateDataSource()
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

