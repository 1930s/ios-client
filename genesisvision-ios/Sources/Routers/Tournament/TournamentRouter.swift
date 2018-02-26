//
//  TournamentRouter.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 11.02.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

enum TournamentRouteType {
    case showDetail(participantID: String), getDetail(participantID: String)
}

class TournamentRouter: Router {
    
    // MARK: - Public methods
    func show(routeType: TournamentRouteType) {
        switch routeType {
        case .getDetail(let participantID):
            _ = getDetail(with: participantID)
        case .showDetail(let participantID):
            showDetail(with: participantID)
        }
    }
    
    func getDetail(with participantID: String) -> TournamentDetailViewController? {
        guard let viewController = TournamentDetailViewController.storyboardInstance(name: .tournament) else { return nil }
        let router = TournamentDetailRouter(parentRouter: self)
        let viewModel = TournamentDetailViewModel(withRouter: router, with: participantID)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Private methods
    private func showDetail(with participantID: String) {
        guard let viewController = TournamentDetailViewController.storyboardInstance(name: .tournament) else { return }
        let router = TournamentDetailRouter(parentRouter: self, navigationController: navigationController)
        let viewModel = TournamentDetailViewModel(withRouter: router, with: participantID)
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

