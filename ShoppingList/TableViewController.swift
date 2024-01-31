//
//  TableViewController.swift
//  ShoppingList
//
//  Created by Zhansen Zhalel on 31.01.2024.
//

import UIKit

class TableViewController: UITableViewController {
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
    }
    
    @objc func promptForItem() {
        let ac = UIAlertController(title: "Enter item name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.items.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        items.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row]
        
        cell.contentConfiguration = content

        return cell
    }
}
