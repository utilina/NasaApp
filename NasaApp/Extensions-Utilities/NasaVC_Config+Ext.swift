//
//  NasaVC_TVConfig+Ext.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 14.12.2020.
//

import Foundation

extension NasaVC {
    
    //MARK: - NavBar settings
    
    public func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Nasa"
        navigationController?.navigationBar.tintColor = .white
        showSearchBarButton(shoulShow: true)
    }
    
    //MARK: - TableView settings
    public func configureTableView() {
        // Row height
        tableView.rowHeight = 110
        // Register cells
        tableView.register(NasaCell.self, forCellReuseIdentifier: Identifier.nasaCell)
        tableView.register(ErrorCell.self, forCellReuseIdentifier: Identifier.errorCell)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: Identifier.loadingCell)
        // Add tableview to view
        view.addSubview(tableView)
        // Set delegates
        tableView.delegate = self
        tableView.dataSource = self
        // Set constraints
        tableViewLayout()
        tableView.backgroundColor = .black
        
    }
    // table view constraints
    func tableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
