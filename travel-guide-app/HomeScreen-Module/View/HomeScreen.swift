//
//  HomeScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class HomeScreen: UIViewController, BaseProtocol {
    
    var collectionView: UICollectionView!
    
    var viewModel: BaseViewModel?

    let uiView = UIView()
    
    let imageView = UIImageView()
    
    let imageLabel = UILabel()
    
    let flightButton = UIButton()
    
    let hotelButton = UIButton()
    
    let stackView1 = UIStackView()
    
    let stackView2 = UIStackView()
    
    let hotelLabel = UILabel()
    
    let flightLabel = UILabel()
    
    let indicator = UIActivityIndicatorView()
    
    let topPickLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        
        
        
        view.addSubview(uiView)
        uiView.addSubview(imageView)
        uiView.addSubview(imageLabel)
        stackView1.addArrangedSubview(flightButton)
        stackView1.addArrangedSubview(hotelButton)
        view.addSubview(stackView1)
        stackView2.addArrangedSubview(flightLabel)
        stackView2.addArrangedSubview(hotelLabel)
        view.addSubview(stackView2)
        view.addSubview(topPickLabel)
        
        
        setupUI()
        viewModel?.didViewLoad()

        
    }
    
    func updateUI() {
        DispatchQueue.main.sync {
            self.collectionView.reloadData()
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
    
    
    
    @objc func toFlightsAndHotels(){
        let vc = FlightsAndHotelsBuilder.createFlightsAndHotelsScreen()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func stackViewSetup(uiObject: AnyObject, stackView: UIStackView, topconstant: CGFloat, spacing: CGFloat, leadingconstant: CGFloat){
        
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: uiObject.bottomAnchor,constant: topconstant).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leadingconstant).isActive = true
        
    }
    
    

}

private extension HomeScreen {
    
    private func setupUI() {
        
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: view.bounds.width * 0.7, height: view.bounds.height * 0.3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromSafeArea


        
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeScreenCell.self, forCellWithReuseIdentifier: "homeScreenCell")
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.topAnchor.constraint(equalTo: uiView.bottomAnchor,constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        

        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        uiView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        uiView.bottomAnchor.constraint(equalTo: view.topAnchor,constant: view.bounds.height * 0.55).isActive = true
        
        
        imageView.image = UIImage(named: "homeimage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: uiView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor).isActive = true
        
        imageLabel.font = .boldSystemFont(ofSize: view.bounds.width * 0.08)
        imageLabel.numberOfLines = 0
        imageLabel.text = "Where's your next destination?"
        imageLabel.textColor = .white
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageLabel.centerYAnchor.constraint(equalTo: uiView.centerYAnchor, constant: view.bounds.height * 0.05).isActive = true
        imageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.03).isActive = true
        imageLabel.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.65).isActive = true
        
        flightButton.setImage(UIImage(named: "flight"), for: .normal)
        flightButton.backgroundColor = .white.withAlphaComponent(0.3)
        flightButton.layer.cornerRadius = 5
        flightButton.addTarget(self, action: #selector(toFlightsAndHotels), for: .touchUpInside)
        
        hotelButton.setImage(UIImage(named: "hotel"), for: .normal)
        hotelButton.backgroundColor = .white.withAlphaComponent(0.3)
        hotelButton.layer.cornerRadius = 5
        hotelButton.addTarget(self, action: #selector(toFlightsAndHotels), for: .touchUpInside)
        
        hotelLabel.text = "Hotels"
        hotelLabel.textColor = .white
        hotelLabel.font = UIFont.systemFont(ofSize: 14)
        
        flightLabel.text = "Flights"
        flightLabel.textColor = .white
        flightLabel.font = UIFont.systemFont(ofSize: 14)
        
        stackViewSetup(uiObject: imageLabel, stackView: stackView1,topconstant: 20,spacing: 20,leadingconstant: view.bounds.width * 0.03)
        stackViewSetup(uiObject: stackView1, stackView: stackView2,topconstant: 10,spacing: 26,leadingconstant: view.bounds.width * 0.03)
        
        topPickLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.05)
        topPickLabel.text = "TOP-PICK ARTICLES"
        topPickLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topPickLabel.topAnchor.constraint(equalTo: uiView.bottomAnchor,constant: 10).isActive = true
        topPickLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15).isActive = true
        
        
    }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeScreenCell", for: indexPath) as! HomeScreenCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        
        cell.configureUI(with: viewModel?.getItem(for: indexPath))
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel?.numberOfItems() ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel?.didSelectData(at: indexPath)
        
    }
}

private extension HomeScreenCell {

    func configureUI(with model: BaseDataTableCell?) {
        name.text = model?.title
        category.text = model?.category
        
        let url:URL? = URL(string: model!.imageUrl)
        let data:Data? = try! Data(contentsOf : url!)
        image.image = UIImage(data : data!)
    
    }
}
