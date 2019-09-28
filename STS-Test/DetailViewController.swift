//
//  DetailViewController.swift
//  STS-Test
//
//  Created by Artem on 28/09/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var instance: Base!
    var fields: [String : Any?]!
    var fieldsList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.instance.typeStr()
        self.fields = self.instance.allFields()
        self.fieldsList = self.instance.fieldsList()
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.instance = nil
        self.fields = nil
    }
}

// MARK: - Table view delegate

extension DetailViewController {
    
}

// MARK: - Table view data source

extension DetailViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fields.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "DetailCell")
        }
        
        let field: String = self.fieldsList[indexPath.section]
        let val: String
        if let value = self.fields[field] {
            val = String(describing: value!)
        } else {
            val = "nil"
        }
        
        cell!.textLabel?.text = field
        cell!.detailTextLabel?.text = val
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
