//
//  ListViewController.swift
//  STS-Test
//
//  Created by Artem on 28/09/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    var elements: [Base] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListCell")
        
        self.computeElements()
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func computeElements() {
        let classes = getClasses()
            
        if classes.isEmpty {
            return
        }
            
        let elsNum = Int.random(in: 10...100)
            
        for _ in 0..<elsNum {
            let cls = classes.randomElement()!
            let inst = cls.init()
            inst.setRandomFields()
            self.elements.append(inst)
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let instance = self.elements[indexPath.row]
                vc.instance = instance
            }
        }
    }
}

// MARK: - Table view data source

extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elements.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let el = self.elements[indexPath.row]
        
        cell.textLabel?.text = "\(el.typeStr())"
        cell.accessoryType = .disclosureIndicator
        
        
        return cell
    }
}

// MARK: - Table view delegate

extension ListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
}
