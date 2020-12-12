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
        tv.register(NasaCell.self, forCellReuseIdentifier: "nasaCell")
        tv.register(ErrorCell.self, forCellReuseIdentifier: "errorCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController()
        sc.searchBar.placeholder = "Search for..."
        return sc
    }()
    
    var networkManager = NetworkManager()
    var imageLoader = ImageLoader()
    var errorStatus: NetworkError?
    
    var nasaArray = [NasaItem]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
    
    private func fetchData(urlString: String = "nebula") {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell") as! ErrorCell
            cell.label.text = "canNotProcessData"
            return cell
        case .noDataAvilable:
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell") as! ErrorCell
            cell.label.text = "noDataAvilable"
            return cell
        case .notFound:
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell") as! ErrorCell
            cell.label.text = "notFound"
            return cell
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nasaCell") as! NasaCell
            cell.nasaImage.image = nil
            cell.nasaSpinner.startAnimating()
            if let imageURL = nasaArray[indexPath.row].links[0].href {
                imageLoader.imageForUrl(urlString: imageURL) { (image, string) in
                    cell.nasaImage.image = image
                    cell.nasaSpinner.stopAnimating()
                }}
            cell.nasaLabel.text = nasaArray[indexPath.row].data[0].title
            return cell
        }
    }
    
    //MARK: - TableView delegate method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Pushing to the next view controller
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        // Get picked country code
        guard let title = nasaArray[indexPath.row].data[0].title else { return }
        guard let link = nasaArray[indexPath.row].links[0].href else { return }
        guard let mediaType = nasaArray[indexPath.row].data[0].media_type else { return }
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
        if let country = searchBar.text {
            // Check if there is some text
            if country != "" {
                let encodeNasa = country.replacingOccurrences(of: " ", with: "%20")
                // Request country
                fetchData(urlString: encodeNasa)
                // If there is no text return all countries
                searchBar.resignFirstResponder()
            }
        }
        
    }
    
}


