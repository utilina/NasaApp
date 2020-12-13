//
//  NasaVC.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import UIKit

class NasaVC: UIViewController {
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 110
        tv.register(NasaCell.self, forCellReuseIdentifier: Identifier.nasaCell)
        tv.register(ErrorCell.self, forCellReuseIdentifier: Identifier.errorCell)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController()
        sc.searchBar.placeholder = "Search for..."
        return sc
    }()
    
    var networkManager: Networking = NetworkManager()
    var errorStatus: NetworkError?
    
    var nasaArray = [NasaItem]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.nasaArray[0].links[0].href)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        configureTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Nasa"
        
    }
    
    func configureTableView() {
        // Add tableview to view
        view.addSubview(tableView)
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        // Set constraints
        tableViewLayout()
    }
    
    func tableViewLayout() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func fetchData(urlString: String = "earth") {
        networkManager.request(request: urlString) { [weak self] result in
            switch result {
            case .success(let nasa):
                self?.nasaArray = nasa
            case .failure(let error):
                self?.errorStatus = error
            }
        }
    }
    
}


extension NasaVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if errorStatus == nil {
            return nasaArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch errorStatus {
        case .canNotProcessData:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.errorCell) as! ErrorCell
            cell.label.text = "canNotProcessData"
            return cell
        case .noDataAvilable:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.errorCell) as! ErrorCell
            cell.label.text = "noDataAvilable"
            return cell
        case .notFound:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.errorCell) as! ErrorCell
            cell.label.text = "notFound"
            return cell
        case .none:
            if nasaArray.count != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.nasaCell) as! NasaCell
                cell.nasaImage.image = nil
                cell.nasaSpinner.startAnimating()
                let imageURL = nasaArray[indexPath.row].links[0].href
                    ImageLoader.sharedLoader.imageForUrl(urlString: imageURL) { (image, string) in
                        cell.nasaImage.image = image
                        cell.nasaSpinner.stopAnimating()
                        if self.nasaArray[indexPath.row].data[0].media_type == "video" {
                            cell.playImage.isHidden = false
                        }
                    }
                cell.nasaLabel.text = nasaArray[indexPath.row].data[0].title
                return cell
            }
        }
        return UITableViewCell()
    }
    
    //MARK: - TableView delegate method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Pushing to the next view controller
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        // Create nasaModel
        guard let title = nasaArray[indexPath.row].data[0].title else { return }
        let link = nasaArray[indexPath.row].links[0].href
        let mediaType = nasaArray[indexPath.row].data[0].media_type
        guard let description = nasaArray[indexPath.row].data[0].description else { return }
        guard let date = nasaArray[indexPath.row].data[0].date_created else { return }
        let nasaModel = NasaModel(title: title, imageURL: link, mediaType: mediaType, date: date, description: description)
        detailViewController.nasaModel = nasaModel
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

//MARK: - Search bar delegate method

extension NasaVC: UISearchBarDelegate {
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        errorStatus = .none
        if let nasaPost = searchBar.text {
            // Check if there is some text
            if nasaPost != "" {
                let encodeNasa = nasaPost.replacingOccurrences(of: " ", with: "%20")
                // Request country
                fetchData(urlString: encodeNasa)
                // If there is no text return all countries
                searchBar.resignFirstResponder()
            }
        }
        
    }
    
}


