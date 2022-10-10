//
//  BookMarksScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit
import CoreData

class BookMarksScreen: UIViewController, BaseProtocol {
    
    var viewModel: BaseViewModel?
    
    let bookMarkLabel = UILabel()
    
    var tableView: UITableView!
    
    let indicator = UIActivityIndicatorView()
    
    var titleArray = [String]()
    
    var idArray = [UUID]()
    
    var descriptionArray = [String]()
    
    var imageArray = [Data]()
    
    var categoryArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(bookMarkLabel)
        
        setupUI()
        viewModel?.didViewLoad()
        
        bookmarkGetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(bookmarkGetData), name: NSNotification.Name(rawValue: "dataSaved"), object: nil)
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
        print("error")
    }
    
    func setupUI(){
        
        bookMarkLabel.text = "Bookmarks"
        bookMarkLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.1)
        bookMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bookMarkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        bookMarkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.separatorColor = .systemBackground
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: "BaseTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: bookMarkLabel.bottomAnchor, constant: view.bounds.height * 0.005).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    @objc func bookmarkGetData() {
        
        titleArray.removeAll(keepingCapacity: false)
        descriptionArray.removeAll(keepingCapacity: false)
        imageArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Travel")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let title = result.value(forKey: "titleTravel") as? String {
                    titleArray.append(title)
                }
                
                if let id = result.value(forKey: "idTravel") as? UUID {
                    idArray.append(id)
                }
                
                if let image = result.value(forKey: "imageTravel") as? Data {
                    imageArray.append(image)
                }
                
                if let description = result.value(forKey: "descriptionTravel") as? String {
                    descriptionArray.append(description)
                }
                
                if let category = result.value(forKey: "categoryTravel") as? String {
                    categoryArray.append(category)
                }
                
            }
            
            tableView.reloadData()
        } catch {
            print("error found")
        }

    }
    
}

extension BookMarksScreen: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTableViewCell",for: indexPath) as! BaseTableViewCell
        cell.name.text = titleArray[indexPath.row]
        cell.desc.text = descriptionArray[indexPath.row]
        let data = imageArray[indexPath.row]
        cell.image.image = UIImage(data: data)
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height * 0.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailScreen()
        navigationController?.pushViewController(vc, animated: true)
        
        let data = imageArray[indexPath.row]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            let userInfo: [String:Any] = ["title": self.titleArray[indexPath.row], "category": self.categoryArray[indexPath.row], "imageData":data, "description": self.descriptionArray[indexPath.row],"buttonHide":true]
            
            NotificationCenter.default.post(name: .init(rawValue: "BookmarkTransfer"), object: nil, userInfo: userInfo )
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Travel")
            let uuidString = idArray[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "idTravel = %@", uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "idTravel") as? UUID {
                            if id == idArray[indexPath.row] {
                                
                                context.delete(result)
                                titleArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                imageArray.remove(at: indexPath.row)
                                descriptionArray.remove(at: indexPath.row)
                                categoryArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do {
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                break
                            }
                        }
                        
                    }
                }
            } catch {
                print("error")
            }
            
        }
        
    }
    
    
}
