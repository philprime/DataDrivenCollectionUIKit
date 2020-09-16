//
//  Set+CellConfigurator.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 28.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

extension Set where Element == CellConfigurator {

    func first<T>(for item: T) -> CellConfigurator? {
        first(where: { $0.itemIdentifier == String(reflecting: item) })
    }
}
