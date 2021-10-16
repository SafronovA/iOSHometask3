//
//  ViewController.swift
//  iOSHometask3
//
//  Created by Aliaksei Safronau EPAM on 7.10.21.
//

import UIKit

class ViewController: UIViewController {
    
    private let baseMargin: CGFloat = 10.0
    private var scaleMultiplier: CGFloat = 1.0
    
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
        containerView.frame = view.safeAreaLayoutGuide.layoutFrame
        containerView.addSubview(redView)
        containerView.addSubview(blueView)
        view.addSubview(button)
        
        activateContainerViewConstraints()
        activateImmutableConstraints()
        activateMutableConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(self.activateMutableConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func scaleSuperview() {
        if(scaleMultiplier.isEqual(to: 1.0)){
            scaleMultiplier = 0.7;
        } else {
            scaleMultiplier = 1.0;
        }
        NSLayoutConstraint.deactivate(getContainerViewConstraints())
        containerViewConstraints = nil
        activateContainerViewConstraints()
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
            
            constraints.append(redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: baseMargin))
            constraints.append(redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: baseMargin))
            
            constraints.append(button.heightAnchor.constraint(equalToConstant: 50))
            constraints.append(button.widthAnchor.constraint(equalTo: button.heightAnchor))
            
            immutableConstraints = constraints
        }
        return immutableConstraints!
    }
    
    private func getContainerViewConstraints() -> [NSLayoutConstraint]{
        if(containerViewConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            constraints.append(containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: scaleMultiplier))
            constraints.append(containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: scaleMultiplier))
            constraints.append(containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
            constraints.append(containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor))
            
            containerViewConstraints = constraints
        }
        return containerViewConstraints!
    }
    
    private func getPortraitConstraints() -> [NSLayoutConstraint]{
        if(portraitConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            
            constraints.append(redView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -baseMargin))
            constraints.append(redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor))
            
            constraints.append(blueView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: baseMargin))
            constraints.append(blueView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -baseMargin))
            constraints.append(blueView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: baseMargin))
            constraints.append(blueView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -baseMargin))
            
            portraitConstraints = constraints
        }
        return portraitConstraints!
    }
    
    private func getLandscapeConstraints() -> [NSLayoutConstraint]{
        if(landscapeConstraints == nil){
            var constraints = [NSLayoutConstraint]()
            constraints.append(redView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
            constraints.append(redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -baseMargin))
            
            constraints.append(blueView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: baseMargin))
            constraints.append(blueView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -baseMargin))
            constraints.append(blueView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -baseMargin))
            constraints.append(blueView.leadingAnchor.constraint(equalTo: redView.trailingAnchor, constant: baseMargin))
            
            landscapeConstraints = constraints
        }
        return landscapeConstraints!
    }
}
