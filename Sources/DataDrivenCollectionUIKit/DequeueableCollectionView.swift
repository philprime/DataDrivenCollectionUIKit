//
//  DequeueableCollectionView.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 28.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

import Foundation

public protocol DequeueableCollectionView {

    associatedtype Cell
    associatedtype ReuseView

    func dequeueCell(with identifier: String, for indexPath: IndexPath) -> Cell
    func dequeueView(with identifier: String, for indexPath: IndexPath, kind: String) -> ReuseView

}
