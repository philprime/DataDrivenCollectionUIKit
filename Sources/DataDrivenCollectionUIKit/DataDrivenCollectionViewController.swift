//
//  DataDrivenCollectionViewController.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 08.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import UIKit
import DifferenceKit

class DataDrivenCollectionViewController<Model: Differentiable, Element: Differentiable>: UICollectionViewController {

    // MARK: - Data Types

    typealias Section = ArraySection<Model, Element>

    // MARK: - Private Variables

    private(set) var dataSource = CollectionDataSource<Model, Element>()

    // MARK: - Initialiser

    init(collectionViewLayout: UICollectionViewLayout, configure: (CollectionDataSource<Model, Element>) -> Void) {
        super.init(collectionViewLayout: collectionViewLayout)

        configure(dataSource)
        dataSource.registerCells(in: collectionView)
        dataSource.registerViews(in: collectionView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not available")
    }

    // MARK: - UI Collection View Data Source & Delegate

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.numberOfSections()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.numberOfItems(in: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource.item(at: indexPath)
        if let anyDiffItem = item as? AnyDifferentiable {
            return dataSource.configuredCell(for: anyDiffItem.base, in: collectionView, at: indexPath)
        }
        return dataSource.configuredCell(for: item, in: collectionView, at: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let item = dataSource.section(at: indexPath.section)
        return dataSource.configuredView(for: item.model, in: collectionView, at: indexPath, kind: kind)
    }

    // MARK: - Updating Data Source

    func update(data: [Section]) {
        dataSource.update(data: data, in: collectionView)
    }
}
