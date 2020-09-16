//
//  CellConfigurator.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 08.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

#if os(iOS)
import UIKit
#endif
import ReusableUI

public struct CellConfigurator {

    public let itemIdentifier: String
    private let cellIdentifier: String
    private let cellType: AnyClass

    let configure: (Any, Any) -> Void

    public init<Item, Cell: Reusable>(itemType: Item.Type, cellType: Cell.Type, _ configure: @escaping (Item, Cell) -> Void) {
        itemIdentifier = String(reflecting: itemType)
        cellIdentifier = cellType.reuseIdentifier
        self.cellType = cellType
        self.configure = { item, cell in
            configure(item as! Item, cell as! Cell) // tailor:disable
        }
    }

    public var reuseIdentifier: String {
        cellIdentifier
    }

    #if os(iOS)
    public func registerCell(in collectionView: UICollectionView) {
        if let nibLoadableType = cellType as? NibLoadable.Type {
            let nib = UINib(nibName: nibLoadableType.nibName, bundle: nibLoadableType.nibBundle)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            collectionView.register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }

    public func registerCell(in tableView: UITableView) {
        tableView.register(cellType, forCellReuseIdentifier: reuseIdentifier)
    }
    #endif
}

// MARK: - Hashable

extension CellConfigurator: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(itemIdentifier)
    }

    public static func == (lhs: CellConfigurator, rhs: CellConfigurator) -> Bool {
        lhs.itemIdentifier == rhs.itemIdentifier
    }
}

// MARK: - Convenience Initializer - Bindable Cell

extension CellConfigurator {

    public init<Item, Cell: Reusable & BindableViewCell>(itemType: Item.Type, cellType: Cell.Type) where Cell.ViewModel == Item {
        self.init(itemType: itemType, cellType: cellType) { (item, cell) in
            cell.bind(viewModel: item)
        }
    }
}
