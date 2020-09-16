//
//  NibLoadable.swift
//  ReusableUI
//
//  Created by Philip Niedertscheider on 03.09.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Foundation
#endif

public protocol NibLoadable: class {
    static var nibName: String { get }
    static var nibBundle: Bundle? { get }
}

extension NibLoadable {

    #if os(iOS)
    public static var nib: UINib {
        UINib(nibName: nibName, bundle: nibBundle)
    }
    #endif

    public static var nibName: String {
        String(describing: self)
    }

    public static var nibBundle: Bundle? {
        Bundle(for: self)
    }
}

#if os(iOS)
extension NibLoadable where Self: UIView {

    public static func loadFromNib() -> Self {
        guard let instance = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            preconditionFailure()
        }
        return instance
    }
}
#endif

public typealias NibReusable = NibLoadable & Reusable
