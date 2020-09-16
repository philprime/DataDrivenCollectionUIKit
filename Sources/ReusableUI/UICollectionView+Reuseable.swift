//
//  UICollectionView+Reusable.swift
//  ReusableUI
//
//  Created by Philip Niedertscheider on 03.09.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

#if os(iOS)
import UIKit

extension UICollectionView {

    public func register<T: UICollectionViewCell>(cellType: T.Type) where T: NibReusable {
        register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func register<T: UICollectionReusableView>(viewType: T.Type, forSupplementaryViewOfKind kind: String) where T: NibReusable {
        register(T.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }

    public func register<T: UICollectionReusableView>(viewType: T.Type, forSupplementaryViewOfKind kind: String) where T: Reusable {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure()
        }
        return cell
    }

    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath, viewType: T.Type = T.self, kind: String) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure()
        }
        return view
    }
}
#endif
