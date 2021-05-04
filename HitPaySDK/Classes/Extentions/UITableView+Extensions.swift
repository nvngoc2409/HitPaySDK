//
//  UITableView+Extensions.swift
//  HitPay
//
//  Created by DieuH on 19/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import Foundation

extension UITableView {
    
    // Register the Cell from XIB with identifer
    func register<T: UITableViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName
        
        var bundle: Bundle?
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    // Register the Cell with identifer
    func register<T: UITableViewCell>(cellClass name: T.Type) where T: ReusableView {
        let identifier = T.defaultReuseIdentifier
        register(name, forCellReuseIdentifier: identifier)
    }
    
    // DequeueReusableCell with identifier
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, atIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}

extension UICollectionView {
    
    // Register the Cell from XIB with identifer
    func register<T: UICollectionViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName
        
        var bundle: Bundle?
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    // Register the Cell with identifer
    func register<T: UICollectionViewCell>(cellClass name: T.Type) where T: ReusableView {
        let identifier = T.defaultReuseIdentifier
        register(name, forCellWithReuseIdentifier: identifier)
    }
    
    // DequeueReusableCell with identifier
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, atIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}
