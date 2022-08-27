//
//  MyStackView.swift
//  Bankey
//
//  Created by srinivas on 23/08/22.
//

import UIKit

class MyStackView: UIView {
    
    
    let places = ["Hyd", "Ban", "Bom", "CHN"]

    let stackView = UIStackView()
//    let userNameTextField = UITextField()
//    let passwordTextField = UITextField()
//    let dividerView = UIView()
    
//    var divider: UIView = {
//        let dividerView = UIView()
//        dividerView.translatesAutoresizingMaskIntoConstraints = false
//        dividerView.backgroundColor = .secondarySystemFill
//        return dividerView
//    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 200, height: 200)
//    }
}

extension MyStackView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
//        dividerView.translatesAutoresizingMaskIntoConstraints = false
//        dividerView.backgroundColor = .secondarySystemFill
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
    }
    
    func layout() {
        
        var i = 0
        places.forEach { place in
            let divider = deviderView()
            divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
            let cell = createView(place)
            stackView.addArrangedSubview(cell)
            if i < place.count {
                stackView.addArrangedSubview(divider)
            }
            i += 1
        }
       
        addSubview(stackView)
        //stack
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
  
    }
}

extension MyStackView {
    
    func createView(_ name: String) -> StackCell {
        let cell = StackCell(name: name)
       return cell
    }
    
    func deviderView() -> UIView {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        return dividerView
    }
    
}

