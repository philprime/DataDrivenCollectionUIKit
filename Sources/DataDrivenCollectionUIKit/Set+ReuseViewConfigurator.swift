//
//  Set+ReuseViewConfigurator.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 28.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

extension Set where Element == ReuseViewConfigurator {

    func first<T>(for item: T) -> ReuseViewConfigurator? {
        first(where: { $0.itemIdentifier == String(reflecting: item) })
    }
}
