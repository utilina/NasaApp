//
//  NotFoundCell.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 12.12.2020.
//

import UIKit

class ErrorCell: UITableViewCell {

    var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        setLabelConstraints()
        self.backgroundColor = .black
    }
    
    func setErrorTitle(error: NetworkError) {
        if error == .canNotProcessData {
            label.text = "Can not process data"
        } else if error == .noDataAvilable {
            label.text = "No data available"
        } else if error == .notFound {
            label.text = "Sorry, nothing found"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    
}
