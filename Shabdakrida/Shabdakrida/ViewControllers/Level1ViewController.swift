//
//  Level1ViewController.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import UIKit

class Level1ViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    let cellIdentifier = "optionCell"
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(OptionTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

}

extension Level1ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OptionTableViewCell
        cell.textLabel?.text = characters[indexPath.section]
        cell.textLabel?.font = UIFont(name: "DevanagariSangamMN", size: 20)
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
