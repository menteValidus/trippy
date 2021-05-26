//
//  RouteCreationViewController.swift
//  Trippy
//
//  Created by Denis Cherniy on 22.05.2021.
//

import UIKit
import TrippyUI

class RouteCreationViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = createCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRootView()
        configureCollectionView()
    }
}

// MARK: - Views Configuration

private extension RouteCreationViewController {
    
    func configureRootView() {
        view.backgroundColor = Asset.Color.primaryBackground.uiColor
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [collectionView.topAnchor.constraint(equalTo: view.topAnchor),
             collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
}

// MARK: - Views Creation

private extension RouteCreationViewController {
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInsetReference = .fromContentInset
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CornerWaypointCollectionViewCell.self,
                                forCellWithReuseIdentifier: CornerWaypointCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }
}

// MARK: - UICollectionViewDelegate

extension RouteCreationViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension RouteCreationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        CornerWaypointCollectionViewCell()
    }
}
