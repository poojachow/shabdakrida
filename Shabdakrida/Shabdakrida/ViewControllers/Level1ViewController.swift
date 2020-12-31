//
//  Level1ViewController.swift
//  Shabdakrida
//
//  Created by Pooja Chowdhary on 12/30/20.
//

import UIKit
import SDWebImage

class Level1ViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellIdentifier = "optionCell"
    var question: QuestionModel?
    
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
//        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    @objc func nextQuestion() {
        question = repository.getQuestion(isNext: true)
        tableView.reloadData()
    }

}

extension Level1ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question?.options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = question?.options[indexPath.row]
        cell.textLabel?.font = UIFont(name: "DevanagariSangamMN", size: 20)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        if let urlString = question?.imageUrl, let url = URL(string: urlString) {
            imageView.sd_setImage(with: url)
        }
        let header = UITableViewHeaderFooterView()
        header.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let option = question?.options[indexPath.row] {
            if option == question?.answer {
                let cell = tableView.cellForRow(at: indexPath)
                cell?.backgroundColor = .green
            }
        }
        perform(#selector(nextQuestion), with: nil, afterDelay: 2)
    }
    
}
