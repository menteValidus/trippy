//
//  RouteCreation.swift
//  Trippy
//
//  Created by Denis Cherniy on 27.07.2021.
//

import SwiftUI
import TrippyUI

struct RouteCreation: View {
    
    // MARK: - Constants
    
    private let cornerEndpointHeight: CGFloat = 210
    private let itemsSpacing: CGFloat = 30
    private let overallContentHorizontalSpacing: CGFloat = 30
    
    // MARK: -
    
    @ObservedObject var viewModel: RouteCreationViewModel
    
    private var amountOfIntermediatePoints: Int {
        viewModel.intermediateWaypoints.count * 2 + 1
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: itemsSpacing) {
                CornerWaypoint()
                    .frame(height: cornerEndpointHeight)
                
                ForEach(0..<amountOfIntermediatePoints, id: \.self) { index in
                    intermediateView(at: index)
                }
                
                CornerWaypoint()
                    .frame(height: cornerEndpointHeight)
                
                GoButton(action: goButtonTapped)
            }
            .padding(.horizontal, overallContentHorizontalSpacing)
        }
        .background(Asset.Color.primaryBackground.color
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity))
        .navigationBarHidden(true)
    }
}

// MARK: Views

private extension RouteCreation {
    
    func intermediateView(at position: Int) -> some View {
        let isEven = position % 2 == 0
        
        if isEven {
            return addWaypointView(at: position).asAnyView
        } else {
            return intermediateWaypoint()
                .frame(height: 60)
                .asAnyView
        }
    }
    
    func addWaypointView(at position: Int) -> AddWaypoint {
        AddWaypoint(buttonAction: {
            addWaypointButtonTapped(at: position / 2)
        })
    }
    
    func intermediateWaypoint() -> IntermediateWaypoint {
        IntermediateWaypoint()
    }
}

// MARK: - Actions

private extension RouteCreation {
    
    func addWaypointButtonTapped(at position: Int) {
        viewModel.insertWaypoint(at: position)
    }
    
    func goButtonTapped() {
        viewModel.proceed()
    }
}

struct RouteCreation_Previews: PreviewProvider {
    
    static var previews: some View {
        let vm = RouteCreationViewModel(flow: .init())
        vm.insertWaypoint(at: 0)
        
        return RouteCreation(viewModel: vm)
    }
}
