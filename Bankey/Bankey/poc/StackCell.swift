//
//  StackCell.swift
//  Bankey
//
//  Created by srinivas on 23/08/22.
//

import UIKit

class StackCell: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    var swicthControl: UISwitch = {
        let swicthControl = UISwitch()
        swicthControl.translatesAutoresizingMaskIntoConstraints = false
        return swicthControl
    }()
    
    var name: String?
    
    required init(name: String) {
        self.name = name
        super.init(frame: .zero)
        setup()
        layout()
    }

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        layout()
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: bounds.width, height: 40)
//    }
//
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        label.text = name
    }
    
    func layout() {
        let stackView = UIStackView(arrangedSubviews: [label, swicthControl])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
//        addSubview(label)
//        addSubview(swicthControl)
        
        // label
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
//            label.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
        
        // switch
        NSLayoutConstraint.activate([
          //  self.trailingAnchor.constraint(equalToSystemSpacingAfter: swicthControl.trailingAnchor, multiplier: 1),
            swicthControl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            swicthControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        
    }
}
