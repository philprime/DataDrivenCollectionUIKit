//
//  UICollectionView+DequeueableCollectionView.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 28.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import UIKit

extension UICollectionView: DequeueableCollectionView {

    public typealias Cell = UICollectionViewCell
    public typealias ReuseView = UICollectionReusableView

    public func dequeueCell(with identifier: String, for indexPath: IndexPath) -> Cell {
        self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }

    public func dequeueView(with identifier: String, for indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
    }
}

