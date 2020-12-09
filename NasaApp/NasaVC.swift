//
//  NasaVC.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import UIKit

class NasaVC: UIViewController {
    
    var tableView = UITableView()
    
    var networkManager = NetworkManager()
    let url = "https://images-api.nasa.gov/search?q=nebula"
    
    var nasaArray = [NasaData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        title = "Nasa"
        networkManager.request(urlString: url) { [weak self] result in
            switch result {
            case .success(let nasa):
                self?.nasaArray = nasa
            case .failure(let error):
                print(error)
            }
        }
        

        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        // Add tableview to view
        view.addSubview(tableView)
        // Set delegates
        setTableViewDelegates()
        // Set row height
        tableView.rowHeight = 200
        // Register Cell
        tableView.register(NasaCell.self, forCellReuseIdentifier: "nasaCell")
        // Set constraints
        tableView.pin(to: view)
        
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}


extension NasaVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nasaCell") as! NasaCell
        
        
        cell.nasaLabel.text = nasaArray[indexPath.row].data[0].title
        return cell
    }
    
    //MARK: - TableView delegate method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
