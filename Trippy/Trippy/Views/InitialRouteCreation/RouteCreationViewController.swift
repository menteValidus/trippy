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
    
    // MARK: - Public Properties
    
    var viewModel: RouteCreationViewModel!
    
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
        view.subviews(collectionView)
        
        collectionView.fillContainer()
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
        collectionView.register(AddWaypointCollectionViewCell.self,
                                forCellWithReuseIdentifier: AddWaypointCollectionViewCell.reuseIdentifier)
        collectionView.register(IntermediateWaypointCollectionViewCell.self,
                                forCellWithReuseIdentifier: IntermediateWaypointCollectionViewCell.reuseIdentifier)
        
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
        switch Section(rawValue: section) {
        case .start:
            return 1
            
        case .intermediate:
            return numberOfItemsInIntermediateSection(for: viewModel.intermediateWaypoints.count)
            
        case .end:
            return 1
            
        case .none:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section) {
        case .start:
            return collectionView.dequeueReusableCell(withReuseIdentifier: CornerWaypointCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
            
        case .intermediate:
            return intermediateWaypointCell(in: collectionView,
                                            for: indexPath)
            
        case .end:
            return collectionView.dequeueReusableCell(withReuseIdentifier: CornerWaypointCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
            
        default:
            assertionFailure("unknown cell")
            return .init()
        }
        
    }
    
    // MARK: Helper Methods
    
    private func numberOfItemsInIntermediateSection(for itemsCount: Int) -> Int {
        itemsCount * 2 + 1
    }
}

// MARK: - Collectio View Cells

private extension RouteCreationViewController {
    
    func intermediateWaypointCell(in collectionView: UICollectionView,
                                  for indexPath: IndexPath) -> UICollectionViewCell {
        let isEven = indexPath.row % 2 == 0
        
        if isEven {
            return collectionView.dequeueReusableCell(withReuseIdentifier: AddWaypointCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: IntermediateWaypointCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
        }
    }
}


extension RouteCreationViewController {
    
    enum Section: Int, CaseIterable {
        case start
        case intermediate
        case end
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
        let vc = RouteCreationViewController()
        let vm = RouteCreationViewModel()
        vc.viewModel = vm
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}

#endif
