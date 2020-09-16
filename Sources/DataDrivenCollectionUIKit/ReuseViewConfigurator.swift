//
//  ReuseViewConfigurator.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 27.04.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

#if os(iOS)
import UIKit
#endif
import ReusableUI

public struct ReuseViewConfigurator {

    public let itemIdentifier: String
    public let kind: String

    private let viewIdentifier: String
    private let viewType: AnyClass

    public let configure: (Any, Any) -> Void

    public init<Item, View: Reusable>(itemType: Item.Type, viewType: View.Type, kind: String, _ configure: @escaping (Item, View) -> Void) {
        itemIdentifier = String(reflecting: itemType)
        viewIdentifier = viewType.reuseIdentifier
        self.viewType = viewType
        self.kind = kind
        self.configure = { item, cell in
            configure(item as! Item, cell as! View) // tailor:disable
        }
    }

    public var reuseIdentifier: String {
        viewIdentifier
    }

    #if os(iOS)
    public func registerView(in collectionView: UICollectionView) {
        collectionView.register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }

    public func registerView(in tableView: UITableView) {
        tableView.register(viewType, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    #endif
}

// MARK: - Hashable

extension ReuseViewConfigurator: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(itemIdentifier)
        hasher.combine(kind)
    }

    public static func == (lhs: ReuseViewConfigurator, rhs: ReuseViewConfigurator) -> Bool {
        lhs.itemIdentifier == rhs.itemIdentifier && lhs.kind == rhs.kind
    }
}

// MARK: - Convenience Initializer - Bindable Cell

extension ReuseViewConfigurator {

    public init<Item, View: Reusable & BindableViewCell>(itemType: Item.Type, viewType: View.Type, kind: String) where View.ViewModel == Item {
        self.init(itemType: itemType, viewType: viewType, kind: kind) { (item, cell) in
            cell.bind(viewModel: item)
        }
    }
}
