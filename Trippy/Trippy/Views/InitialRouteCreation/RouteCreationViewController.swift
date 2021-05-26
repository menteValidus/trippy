//
//  RouteCreationViewController.swift
//  Trippy
//
//  Created by Denis Cherniy on 22.05.2021.
//

import UIKit
import TrippyUI

class RouteCreationViewController: UIViewController {
    
    // MARK: - Constants
    
    private let cellsSpacing: CGFloat = 30
    private let horizontalCellPadding: CGFloat = 30
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = createCollectionView()

    // MARK: - View Lifecycle
    
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

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createCompositionalLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CornerWaypointCollectionViewCell.self,
                                forCellWithReuseIdentifier: CornerWaypointCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitem: item,
                                                       count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: horizontalCellPadding,
                                                        bottom: 0,
                                                        trailing: horizontalCellPadding)
        section.interGroupSpacing = cellsSpacing
        
        return UICollectionViewCompositionalLayout(section: section)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: CornerWaypointCollectionViewCell.reuseIdentifier, for: indexPath)
    }
}


#if DEBUG

import SwiftUI

struct RouteCreationViewController_Previews: PreviewProvider, UIViewControllerRepresentable {
    
    static var previews: some View {
        Self()
            .previewLayout(.sizeThatFits)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        RouteCreationViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

#endif
