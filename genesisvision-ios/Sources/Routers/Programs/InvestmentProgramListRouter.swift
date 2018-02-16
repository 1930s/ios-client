//
//  InvestmentProgramListRouter.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 26.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

enum ProgramRouteType {
    case signIn, showProgramDetail(programEntity: InvestmentProgramEntity), showFilterVC(investmentProgramListViewModel: InvestmentProgramListViewModel)
}

class InvestmentProgramListRouter: Router {
    
    // MARK: - Public methods
    func show(routeType: ProgramRouteType) {
        switch routeType {
        case .signIn:
            signInAction()
        case .showFilterVC(let investmentProgramListViewModel):
            showFilterVC(with: investmentProgramListViewModel)
        case .showProgramDetail(let programEntity):
            showProgramDetail(with: programEntity)
        }
    }
    
    func getDetailViewController(withEntity entity: InvestmentProgramEntity) -> ProgramDetailViewController? {
        guard let traderViewController = ProgramDetailViewController.storyboardInstance(name: .traders) else { return nil }
        let router = ProgramDetailRouter(parentRouter: self)
        let viewModel = ProgramDetailViewModel(withRouter: router, with: entity)
        traderViewController.viewModel = viewModel
        
        return traderViewController
    }
    
    // MARK: - Private methods
    private func signInAction() {
        guard let viewController = SignInViewController.storyboardInstance(name: .auth) else { return }
        let router = SignInRouter(parentRouter: self, navigationController: navigationController)
        childRouters.append(router)
        viewController.viewModel = SignInViewModel(withRouter: router)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showProgramDetail(with programEntity: InvestmentProgramEntity) {
        guard let viewController = ProgramDetailViewController.storyboardInstance(name: .traders) else { return }
        let router = ProgramDetailRouter(parentRouter: self, navigationController: navigationController)
        let viewModel = ProgramDetailViewModel(withRouter: router, with: programEntity)
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showFilterVC(with investmentProgramListViewModel: InvestmentProgramListViewModel) {
        guard let viewController = FilterViewController.storyboardInstance(name: .traders) else { return }
        let router = FilterRouter(parentRouter: self, navigationController: navigationController)
        let viewModel = FilterViewModel(withRouter: router, investmentProgramListViewModel: investmentProgramListViewModel)
        viewController.viewModel = viewModel
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}