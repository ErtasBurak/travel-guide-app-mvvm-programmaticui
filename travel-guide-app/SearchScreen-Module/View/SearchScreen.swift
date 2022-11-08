//
//  SearchScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class SearchScreen: UIViewController, BaseProtocol {

    var viewModel: BaseViewModel?
    
    let searchLabel = UILabel()
    
    let searchBar = UISearchBar()
    
    var searchTableView: UITableView!
    
    let indicator = UIActivityIndicatorView()
    
    var indexPath: IndexPath?
    
    var filteredData: [BaseDataTableCell] = []
    
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
        print("error")
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
        searchTableView.register(BaseTableViewCell.self, forCellReuseIdentifier: "BaseTableViewCell")
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
            if filteredData.isEmpty {
                searchTableView.setEmptyMessage("No data for this searchword!")
                return filteredData.count
            }else{
                searchTableView.restore()
                return filteredData.count
            }
           
        } else{
            if searchTableView.visibleCells.isEmpty {
                searchTableView.setEmptyMessage("No data for this searchword!")
            }else{
                searchTableView.restore()
            }
            return viewModel?.numberOfItems() ?? 0
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell",for: indexPath) as! BaseTableViewCell
        
        if searching == true {
            cell.name.text = filteredData[indexPath.row].title
            cell.desc.text = filteredData[indexPath.row].description
            
            if let url: URL = URL(string: filteredData[indexPath.row].imageUrl) {
                DispatchQueue.global().async {
                    if let data: Data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.image.image = UIImage(data: data)
                        }
                    }
                }
            }
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

private extension BaseTableViewCell {
    
    func configureUI(with model: BaseDataTableCell?) {
        name.text = model?.title
        desc.text = model?.description
        
        
        if let url: URL = URL(string: model?.imageUrl ?? "") {
            DispatchQueue.global().async {
                if let data: Data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }
}


extension SearchScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            filteredData = viewModel!.uiModel
        }else{
            filteredData = viewModel!.uiModel.filter ({ data_ -> Bool in
                data_.title.contains(searchText)
                })
        }
        
        searchTableView.reloadData()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }
    
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
  
        let image = UIImage(systemName: "xmark.bin.fill")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: uiView.bounds.size.width * 0.2, y: uiView.bounds.size.height * 0.1, width: uiView.bounds.size.width * 0.6, height: uiView.bounds.size.height * 0.5)
        
        let messageLabel = UILabel(frame: CGRect(x: uiView.bounds.size.width * 0.2, y: uiView.bounds.size.height * 0.6, width: uiView.bounds.size.width * 0.6, height: uiView.bounds.size.height * 0.1))
        messageLabel.text = message
        messageLabel.textColor = .blue
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        uiView.addSubview(imageView)
        uiView.addSubview(messageLabel)

        self.backgroundView = uiView
        
    }

    func restore() {
        self.backgroundView = nil
        
    }
    
}
