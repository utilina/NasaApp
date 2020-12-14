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
        tv.separatorColor = .darkGray
        return tv
    }()
    
    var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search for..."
        sb.barStyle = .black
        return sb
    }()
    
    private var networkManager: Networking = NetworkManager()
    private var errorStatus: NetworkError?
    private var loadingStatus: Bool?
    
    private var nasaArray = [NasaItem]() {
        didSet {
            loadingStatus = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch start request
        fetchData()
        loadingStatus = true
        // Searchbar delegate
        searchBar.delegate = self
        searchBar.sizeToFit()
        // Navbar view settings
        configureNavBar()
        // Table view settings
        configureTableView()
    }
    
    //MARK: - Fetching data request from nasa API
    private func fetchData(urlString: String = "crab") {
        networkManager.request(request: urlString) { [weak self] result in
            switch result {
            case .success(let nasa):
                // Get decoded data from api, set this data to nasaArray
                self?.nasaArray = nasa
            case .failure(let error):
                // Set error status to display error cell
                self?.errorStatus = error
            }
        }
    }
}

//MARK: - TableView datasource methods
extension NasaVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if errorStatus == nil {
            return nasaArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Check if posts load, show loading cells if it is true
        if loadingStatus == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.loadingCell) as! LoadingCell
            cell.loadingSpinner.startAnimating()
            return cell
        }
        // Catch errors, display error cells
        let errorCell = tableView.dequeueReusableCell(withIdentifier: Identifier.errorCell) as! ErrorCell
        switch errorStatus {
        case .canNotProcessData:
            errorCell.setErrorTitle(error: .canNotProcessData)
            return errorCell
        case .noDataAvilable:
            errorCell.setErrorTitle(error: .noDataAvilable)
            return errorCell
        case .notFound:
            errorCell.setErrorTitle(error: .notFound)
            return errorCell
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.nasaCell) as! NasaCell
            // Clear cells images
            cell.clearImages()
            if let imageURL = nasaArray[indexPath.row].links[0].href {
                ImageLoader.sharedLoader.imageForUrl(urlString: imageURL) { (image, string) in
                    // Set new nasa image
                    cell.nasaImage.image = image
                    // Stop loading animation
                    cell.nasaSpinner.stopAnimating()
                    // Set play image if it is video
                    if self.nasaArray[indexPath.row].data[0].media_type == "video" {
                        cell.playImage.isHidden = false
                    } else {
                        cell.playImage.isHidden = true
                    }
                }
            }
            // Set title
            cell.nasaLabel.text = nasaArray[indexPath.row].data[0].title
            return cell
        }
    }
    
    //MARK: - TableView delegate method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Pushing to the next view controller
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        // Create nasaModel
        let nasaModel = createNasaModel(forIndexPath: indexPath)
        // Set detail view controller nasa model
        detailViewController.nasaModel = nasaModel
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createNasaModel(forIndexPath indexPath: IndexPath) -> NasaModel? {
        guard let title = nasaArray[indexPath.row].data[0].title else { return nil }
        guard let link = nasaArray[indexPath.row].links[0].href else { return nil }
        guard let mediaType = nasaArray[indexPath.row].data[0].media_type else { return nil }
        guard let description = nasaArray[indexPath.row].data[0].description else { return nil }
        guard let date = nasaArray[indexPath.row].data[0].date_created else { return nil }
        let nasaModel = NasaModel(title: title, imageURL: link, mediaType: mediaType, date: date, description: description)
        return nasaModel
    }
}

//MARK: - Search bar delegate method

extension NasaVC: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Start loading animation
        loadingStatus = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        // Clear error status
        errorStatus = .none
        
        if let nasaPost = searchBar.text {
            // Check if there is some text
            if nasaPost != "" {
                let encodeNasa = nasaPost.formatedForUrl
                // Request nasa data
                fetchData(urlString: encodeNasa)
                // If there is no text return all countries
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(shoulShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        
    }
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func showSearchBarButton(shoulShow: Bool) {
        if shoulShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}


