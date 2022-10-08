//
//  FlightsAndHotels.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 1.10.2022.
//

import UIKit

class FlightsAndHotels: UIViewController, HomeScreenViewProtocol {
    
    var viewModel: HomeScreenViewModel?
    
    let flihotlabel = UILabel()
    
    var tableView: UITableView!
    
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        
        
        
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
        view.addSubview(flihotlabel)
        
        
        
        
        flihotlabel.text = "parametre"
        flihotlabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.1)
        flihotlabel.translatesAutoresizingMaskIntoConstraints = false
        
        flihotlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        flihotlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.1).isActive = true
        
        let fancyImage = UIImage(systemName: "arrow.backward.to.line.circle")
        let fancyAppearance = UINavigationBarAppearance()
        fancyAppearance.configureWithTransparentBackground()
        fancyAppearance.setBackIndicatorImage(fancyImage, transitionMaskImage: fancyImage)
        let backButtonAppearence = UIBarButtonItemAppearance()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        backButtonAppearence.normal.titleTextAttributes = titleTextAttributes
        backButtonAppearence.highlighted.titleTextAttributes = titleTextAttributes
        fancyAppearance.backButtonAppearance = backButtonAppearence

        navigationController?.navigationBar.standardAppearance = fancyAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = fancyAppearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = fancyAppearance
        
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.separatorColor = .systemBackground
        tableView.register(FlightsAndHotelsCell.self, forCellReuseIdentifier: "flightsandhotelscell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: flihotlabel.bottomAnchor, constant: view.bounds.height * 0.005).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
    }

}

extension FlightsAndHotels: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightsandhotelscell",for: indexPath) as! FlightsAndHotelsCell
        cell.configureUI(with: viewModel?.getItem(for: indexPath))
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

private extension FlightsAndHotelsCell {
    
    func configureUI(with model: HomeDataTableCellModel?) {
        name.text = model?.title
        desc.text = model?.description
        
        let url: URL? = URL(string: model?.imageUrl ?? "")
        let data: Data? = try? Data(contentsOf : url!)
        image.image = UIImage(data : data!)
    }
}
