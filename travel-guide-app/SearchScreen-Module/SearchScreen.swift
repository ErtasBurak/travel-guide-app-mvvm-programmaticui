//
//  SearchScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class SearchScreen: UIViewController, HomeScreenViewProtocol {

    var viewModel: HomeScreenViewModel?
    
    let searchLabel = UILabel()
    
    let searchBar = UISearchBar()
    
    var searchTableView: UITableView!
    
    let indicator = UIActivityIndicatorView()
    
    var indexPath: IndexPath?
    
    var filteredData: [HomeDataTableCellModel] = []
    
    var searching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(searchLabel)
        view.addSubview(searchBar)

        
        setupUI()
        viewModel?.didViewLoad()
        
        searchBar.delegate = self
        
    }
    
    func updateUI() {
        DispatchQueue.main.sync {
            self.searchTableView.reloadData()
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
        
        searchLabel.text = "Search"
        searchLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.1)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        
        searchBar.placeholder = "Where next?"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor,constant: view.bounds.height * 0.05).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.05).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.bounds.width * 0.05).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.1).isActive = true
        
        searchTableView = UITableView(frame: CGRect.zero)
        searchTableView.separatorColor = .systemBackground
        searchTableView.register(FlightsAndHotelsCell.self, forCellReuseIdentifier: "flightsandhotelscell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        view.addSubview(searchTableView)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        
        searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: view.bounds.height * 0.005).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
}

extension SearchScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true {
            return filteredData.count
        } else{
            return viewModel?.numberOfItems() ?? 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightsandhotelscell",for: indexPath) as! FlightsAndHotelsCell
        
        if searching == true {
            cell.name.text = filteredData[indexPath.row].title
            cell.desc.text = filteredData[indexPath.row].description
            let url: URL? = URL(string: filteredData[indexPath.row].imageUrl)
            let data: Data? = try? Data(contentsOf : url!)
            cell.image.image = UIImage(data : data!)
            cell.selectionStyle = .none
            return cell
            
        }else{
            cell.configureUI(with: viewModel?.getItem(for: indexPath))
            cell.selectionStyle = .none
            return cell
            
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height * 0.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searching == true {
            let vc = DetailScreen()
            navigationController?.pushViewController(vc, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                
                let userInfo: [String:String] = ["title": self.filteredData[indexPath.row].title, "category": self.filteredData[indexPath.row].category, "image": self.filteredData[indexPath.row].imageUrl, "description": self.filteredData[indexPath.row].description]
                
                NotificationCenter.default.post(name: .init(rawValue: "DetailTransfer"), object: nil, userInfo: userInfo)
                
            }
        }else{
            viewModel?.didSelectData(at: indexPath)
        }

        
    }
    
    
}

private extension FlightsAndHotelsCell {
    
    func configureUI(with model: HomeDataTableCellModel?) {
        name.text = model?.title
        desc.text = model?.description
        
        let url: URL? = URL(string: model?.imageUrl ?? "")
        let data: Data? = try? Data(contentsOf : url!)
        image.image = UIImage(data : data!)
    }
}


extension SearchScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredData = viewModel!.uiModel
            return
            
        }
        
        filteredData = viewModel!.uiModel.filter ({ data_ -> Bool in
            data_.title.contains(searchText)
            })
        
        
        searchTableView.reloadData()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }
    
}
