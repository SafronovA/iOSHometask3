//
//  ViewController.swift
//  iOSHometask3
//
//  Created by Aliaksei Safronau EPAM on 7.10.21.
//

import UIKit

class ViewController: UIViewController {
    
    private let baseMargin: CGFloat = 10.0
    private var viewScaled: Bool = false
    private var scaleMultiplier: CGFloat = 0.0

    private let containerView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .cyan
        return customView
    }()
    
    private let redView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .red
        return customView
    }()
    
    private let blueView: UIView = {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .link
        return customView
    }()
    
    private let button: UIButton = {
        let customButton = UIButton()
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.backgroundColor = .black
        customButton.setTitle("30%", for: .normal)
        customButton.addTarget(self, action: #selector(scaleSuperview), for: .touchUpInside)
        return customButton
    }()
    
    private var immutableConstraints: [NSLayoutConstraint]?
    private var containerViewConstraints: [NSLayoutConstraint]?
    private var portraitConstraints: [NSLayoutConstraint]?
    private var landscapeConstraints: [NSLayoutConstraint]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(redView)
        containerView.addSubview(blueView)
        containerView.addSubview(button)
        
        activateContainerViewConstraints()
        activateImmutableConstraints()
        activateMutableConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(self.activateMutableConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func scaleSuperview() {
        if(viewScaled){
            
        }
    }
    
    private func activateContainerViewConstraints(){
        NSLayoutConstraint.activate(getContainerViewConstraints())
    }
    
    private func activateImmutableConstraints(){
        NSLayoutConstraint.activate(getImmutableConstraints())
    }
    
    @objc private func activateMutableConstraints(){
        if UIDevice.current.orientation.isLandscape {
            if(portraitConstraints != nil){
                NSLayoutConstraint.deactivate(portraitConstraints!)
            }
            NSLayoutConstraint.activate(getLandscapeConstraints())
        } else {
            if(landscapeConstraints != nil){
                NSLayoutConstraint.deactivate(landscapeConstraints!)
            }
            NSLayoutConstraint.activate(getPortraitConstraints())
        }
    }
    
    private func getImmutableConstraints() -> [NSLayoutConstraint]{
        if(immutableConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            constraints.append(redView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: baseMargin))
            constraints.append(redView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: baseMargin))
            constraints.append(redView.heightAnchor.constraint(equalTo: blueView.heightAnchor))
            constraints.append(redView.widthAnchor.constraint(equalTo: blueView.widthAnchor))
            
            constraints.append(button.heightAnchor.constraint(equalTo: redView.heightAnchor, multiplier: 0.2))
            constraints.append(button.widthAnchor.constraint(equalTo: button.heightAnchor))
            
            immutableConstraints = constraints
        }
        return immutableConstraints!
    }
    
    private func getContainerViewConstraints() -> [NSLayoutConstraint]{
        if(containerViewConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            // верхняя safeArea что-то не работает
            //            constraints.append(containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor))
            //            constraints.append(containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor))
            
//            constraints.append(containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
//            constraints.append(containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
//            constraints.append(containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
//            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
            
            constraints.append(containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height * scaleMultiplier))
            constraints.append(containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.bounds.height * scaleMultiplier)))
            
            containerViewConstraints = constraints
        }
        return containerViewConstraints!
    }
    
    private func getPortraitConstraints() -> [NSLayoutConstraint]{
        if(portraitConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            constraints.append(redView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -baseMargin))
            //            constraints.append(redView.bottomAnchor.constraint(equalTo: blueView.topAnchor, constant: -baseMargin))
            constraints.append(redView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -baseMargin))
            constraints.append(blueView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -baseMargin))
            constraints.append(blueView.centerXAnchor.constraint(equalTo: redView.centerXAnchor))
            
            constraints.append(button.bottomAnchor.constraint(equalTo: blueView.topAnchor, constant: -baseMargin))
            constraints.append(button.centerXAnchor.constraint(equalTo: redView.centerXAnchor))
            
            portraitConstraints = constraints
        }
        return portraitConstraints!
    }
    
    private func getLandscapeConstraints() -> [NSLayoutConstraint]{
        if(landscapeConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            //            constraints.append(redView.trailingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: -baseMargin))
            constraints.append(redView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -baseMargin))
            constraints.append(redView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -baseMargin))
            constraints.append(blueView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -baseMargin))
            constraints.append(blueView.centerYAnchor.constraint(equalTo: redView.centerYAnchor))
            
            constraints.append(button.trailingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: -baseMargin))
            constraints.append(button.centerYAnchor.constraint(equalTo: redView.centerYAnchor))
            
            landscapeConstraints = constraints
        }
        return landscapeConstraints!
    }
}
