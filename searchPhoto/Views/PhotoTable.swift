//
//  PhotoTable.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/20/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit


class PhotoTable: UITableView {
    var customElements: [CustomCellModel]!
    {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = self.superview else { return }
        NSLayoutConstraint.activate([
            self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: superView.topAnchor),
            self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            ])
    }
    
    
    func setupTableView(cellType: CustomCellType) {
        setConstraints()
        tableFooterView = UIView(frame: .zero)
        register(UITableViewCell.self, forCellReuseIdentifier: cellType.rawValue)
        allowsSelection = false
        dataSource = self
        delegate = self
    }
}
extension PhotoTable: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let elements = customElements else { return 0 }
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = customElements[indexPath.row]
        let cellIdentifier = cellModel.cellType.rawValue
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let data = (cellModel as! StandartCell)
        customCell.imageView?.image = data.image
        customCell.textLabel?.text = data.author
        return customCell
    }
    
    
}
