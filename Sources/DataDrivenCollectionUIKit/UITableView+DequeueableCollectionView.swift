//
//  UITableView+DequeueableCollectionView.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 28.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import UIKit

extension UITableView: DequeueableCollectionView {

    public typealias Cell = UITableViewCell
    public typealias ReuseView = UITableViewHeaderFooterView

    public func dequeueCell(with identifier: String, for indexPath: IndexPath) -> Cell {
        self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

    public func dequeueView(with identifier: String, for indexPath: IndexPath, kind: String) -> ReuseView {
        self.dequeueReusableHeaderFooterView(withIdentifier: identifier)!
    }
}
