//
//  DataDrivenTableViewController.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 11.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import UIKit
import DifferenceKit

class DataDrivenTableViewController<Model: Differentiable, Element: Differentiable>: UITableViewController {

    // MARK: - Types

    typealias Section = ArraySection<Model, Element>

    // MARK: - Private Variables

    private(set) var dataSource = CollectionDataSource<Model, Element>()

    // MARK: - Initialiser

    init(style: UITableView.Style, configure: (CollectionDataSource<Model, Element>) -> Void) {
        super.init(style: style)

        configure(dataSource)
        dataSource.registerCells(in: tableView)
        dataSource.registerViews(in: tableView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not available")
    }

    // MARK: - UI Collection View Data Source & Delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.numberOfItems(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource.item(at: indexPath)
        if let anyDiffItem = item as? AnyDifferentiable {
            return dataSource.configuredCell(for: anyDiffItem.base, in: tableView, at: indexPath)
        }
        return dataSource.configuredCell(for: item, in: tableView, at: indexPath)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = dataSource.section(at: section)
        return dataSource.configuredView(for: item.model, in: tableView, at: IndexPath(item: 0, section: section), kind: "header")
    }

    // MARK: - Updating Data Source

    func update(data: [Section]) {
        dataSource.update(data: data, in: tableView)
    }
}
