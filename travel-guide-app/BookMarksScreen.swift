//
//  BookMarksScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class BookMarksScreen: UIViewController, HomeScreenViewProtocol {
    
    var viewModel: HomeScreenViewModel?
    
    let bookMarkLabel = UILabel()
    
    var tableView: UITableView!
    
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(bookMarkLabel)
        
        setupUI()
        viewModel?.didViewLoad()
    }
    
    func updateUI() {
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    
    func showLoading() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func hideLoading() {
        indicator.isHidden = true
        indicator.stopAnimating()
    }
    
    func showError(with message: String?) {
        
    }
    
    func setupUI(){
        
        bookMarkLabel.text = "Bookmarks"
        bookMarkLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.1)
        bookMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bookMarkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        bookMarkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.separatorColor = .systemBackground
        tableView.register(FlightsAndHotelsCell.self, forCellReuseIdentifier: "flightsandhotelscell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: bookMarkLabel.bottomAnchor, constant: view.bounds.height * 0.005).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
}

extension BookMarksScreen: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightsandhotelscell",for: indexPath) as! FlightsAndHotelsCell
        cell.name.text = "dawd"
        cell.desc.text = "dwada"
        cell.image.image = UIImage(named: "homeimage")
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height * 0.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectData(at: indexPath)
    }
    
    
}
