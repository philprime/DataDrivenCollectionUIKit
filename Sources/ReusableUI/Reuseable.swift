//
//  Reusable.swift
//  ReusableUI
//
//  Created by Philip Niedertscheider on 03.09.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

public protocol Reusable: class {

    static var reuseIdentifier: String { get }
    
}

extension Reusable {

    public static var reuseIdentifier: String {
        String(reflecting: self)
    }
}
