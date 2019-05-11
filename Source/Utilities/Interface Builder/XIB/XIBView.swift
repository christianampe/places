//
//  XIBView.swift
//  Client
//
//  Created by Christian Ampe on 11/13/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit

/// XIB superview used to constrain and set up
/// the interface loaded from a xib.
class XIBView: UIView {
    
    /// The view containing the interface loaded from the xib.
    private weak var view: UIView!
    
    /// Initializes and returns a newly
    /// allocated view object with the specified frame rectangle.
    ///
    /// - Parameter frame: Size and location of the view.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    /// Returns an object initialized from
    /// data in a given unarchiver.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
}

// MARK: Private Helper Methods
private extension XIBView {
    
    /// A method used to create and constrain the loaded
    /// xib view.
    func setUp() {
        create()
        constrain()
    }
    
    /// This method creates the view from the xib and
    /// adds this view to the superview.
    func create() {
        view = instantiateXIB()
        addSubview(view)
    }
    
    /// This method constrains the view to the superview.
    func constrain() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    /// A generic method used to load a xib from its storyboard
    /// identifier extracted from the projects bundle.
    ///
    /// - Returns: A view loaded from a xib.
    func instantiateXIB<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName))")
        }
        
        return view
    }
}
