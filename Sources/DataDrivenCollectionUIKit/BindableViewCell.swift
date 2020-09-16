//
//  BindableViewCell.swift
//  DataDrivenCollectionUIKit
//
//  Created by Philip Niedertscheider on 28.03.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

public protocol BindableViewCell {

    associatedtype ViewModel

    func bind(viewModel: ViewModel)

}
