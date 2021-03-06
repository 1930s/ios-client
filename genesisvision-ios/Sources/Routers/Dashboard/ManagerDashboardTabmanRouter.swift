//
//  ManagerDashboardTabmanRouter.swift
//  genesisvision-ios
//
//  Created by George on 27/07/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

class ManagerDashboardTabmanRouter: TabmanRouter {
    // MARK: - Variables
    var programDetailViewController: ProgramInfoViewController?
    
    // MARK: - Public methods
    func getDashboard() -> ManagerDashboardViewController? {
        let viewController = ManagerDashboardViewController()
        
        let navigationController = BaseNavigationController(rootViewController: viewController)
        let router = DashboardRouter(parentRouter: self, navigationController: navigationController, dashboardViewController: viewController)
        viewController.viewModel = DashboardViewModel(withRouter: router)
        
        return viewController
    }
}

