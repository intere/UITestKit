//
//  ShapesTableViewController.swift
//  UITestKit_Example
//
//  Created by Eric Internicola on 12/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ShapesTableViewController: UITableViewController {

    var shapes = [Shape]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ShapeTableViewCell.self, forCellReuseIdentifier: "Shape")

        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationItem.rightBarButtonItem?.target = self
        navigationController?.navigationItem.rightBarButtonItem?.action = #selector(addShape(_:))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shapes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Shape", for: indexPath)

        guard let shapeCell = cell as? ShapeTableViewCell else {
            return cell
        }
        shapeCell.shape = shapes[indexPath.row]

        return shapeCell
    }

}

// MARK: - User Actions

private extension ShapesTableViewController {

    @IBAction
    func addShape(_ source: UIBarButtonItem) {
        guard shapes.count < Shape.allCases.count else {
            return
        }
        shapes.append(Shape.allCases[shapes.count])
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: shapes.count-1, section: 0), at: .bottom, animated: true)

        if shapes.count == Shape.allCases.count {
            source.isEnabled = false
        }
    }

}
