//
//  CollectionDataSource.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 08.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import UIKit
import DifferenceKit

public class CollectionDataSource<Model: Differentiable, Element: Differentiable> {

    public typealias Filter = (Element) -> Bool
    public typealias Section = ArraySection<Model, Element>

    private (set) var configurators: Set<CellConfigurator> = []
    private (set) var reuseViewConfigurators: Set<ReuseViewConfigurator> = []

    private var data: [Section]
    private var filteredData: [Section]?
    private var filter: Filter?

    public init(data: [Section] = [], filter: Filter? = nil) {
        self.data = data
        self.filter = filter
        if let filter = filter {
            self.filteredData = data.map { ArraySection(source: $0, elements: $0.elements.filter(filter)) }
        }
    }

    public func registerCells(in collectionView: UICollectionView) {
        for configurator in configurators {
            configurator.registerCell(in: collectionView)
        }
    }

    public func registerViews(in collectionView: UICollectionView) {
        for configurator in reuseViewConfigurators {
            configurator.registerView(in: collectionView)
        }
    }

    public func registerCells(in tableView: UITableView) {
        for configurator in configurators {
            configurator.registerCell(in: tableView)
        }
    }

    public func registerViews(in tableView: UITableView) {
        for configurator in reuseViewConfigurators {
            configurator.registerView(in: tableView)
        }
    }

    public func update(data: [Section], in collectionView: UICollectionView) {
        let changeset = StagedChangeset(source: self.data, target: data)
        collectionView.reload(using: changeset) { data in
            self.data = data
        }
    }

    public func update(data: [Section], in tableView: UITableView) {
        let changeset = StagedChangeset(source: self.data, target: data)
        tableView.reload(using: changeset, with: .automatic) { data in
            self.data = data
        }
    }

    public func update(filter: Filter?, in tableView: UITableView) {
        self.filter = filter
        let filteredData: [Section]?
        if let filter = filter {
            filteredData = self.data.map { section in
                ArraySection(source: section, elements: section.elements.filter(filter))
            }
        } else {
            filteredData = nil
        }
        let changeset = StagedChangeset(source: self.filteredData ?? self.data, target: filteredData ?? self.data)
        tableView.reload(using: changeset, with: .automatic) { data in
            self.filteredData = data
        }
    }

    public func add(_ configurator: CellConfigurator) {
        guard !configurators.contains(configurator) else {
            preconditionFailure("Can not implement multipe configurators for same item")
        }
        configurators.insert(configurator)
    }

    public func add(_ configurator: ReuseViewConfigurator) {
        guard !reuseViewConfigurators.contains(configurator) else {
            preconditionFailure("Can not implement multipe configurators for same view item")
        }
        reuseViewConfigurators.insert(configurator)
    }

    public func configuredCell<T, V: DequeueableCollectionView>(for item: T, in view: V, at indexPath: IndexPath) -> V.Cell {
        guard let configurator = configurators.first(for: item) else {
            preconditionFailure("Configurator for \(item) not found. Are you sure you registered a configurator?")
        }
        let cell = view.dequeueCell(with: configurator.reuseIdentifier, for: indexPath)
        configurator.configure(item, cell)
        return cell
    }

    public func configuredView<T, V: DequeueableCollectionView>(for item: T, in view: V, at indexPath: IndexPath, kind: String) -> V.ReuseView {
        guard let configurator = reuseViewConfigurators.first(for: item) else {
            preconditionFailure("Configurator for \(item) not found. Are you sure you registered a configurator?")
        }
        let cell = view.dequeueView(with: configurator.reuseIdentifier, for: indexPath, kind: kind)
        configurator.configure(item, cell)
        return cell
    }

    public func numberOfSections() -> Int {
        (filteredData ?? data).count
    }

    public func numberOfItems(in section: Int) -> Int {
        (filteredData ?? data)[section].elements.count
    }

    public func item(at indexPath: IndexPath) -> Element {
        (filteredData ?? data)[indexPath.section].elements[indexPath.item]
    }

    public func section(at index: Int) -> Section {
        (filteredData ?? data)[index]
    }
}
