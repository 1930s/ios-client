//
//  EventListViewModel.swift
//  genesisvision-ios
//
//  Created by George on 24/09/2018.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit.UICollectionView

class EventListViewModel {
    enum SectionType {
        case eventList
    }
    
    // MARK: - Variables
    var title = "Portfolio Events"
    
    private var sections: [SectionType] = [.eventList]
    
    var router: DashboardRouter!
    var dashboardPortfolioEvents: DashboardPortfolioEvents? {
        didSet {
            var dashboardEventsViewModels = [PortfolioEventCollectionViewCellViewModel]()
            
            dashboardPortfolioEvents?.events?.forEach({ (event) in
                let dashboardEventViewModel = PortfolioEventCollectionViewCellViewModel(reloadDataProtocol: router?.eventsViewController, dashboardPortfolioEvent: event)
                dashboardEventsViewModels.append(dashboardEventViewModel)
            })
            
            viewModels = dashboardEventsViewModels

            reloadDataProtocol?.didReloadData()
        }
    }
    
    var eventsDelegateManager: EventsDelegateManager!
    weak var reloadDataProtocol: ReloadDataProtocol?
    
    var viewModels = [PortfolioEventCollectionViewCellViewModel]()
    
    init(withRouter router: DashboardRouter, dashboardPortfolioEvents: DashboardPortfolioEvents?) {
        self.router = router
        self.dashboardPortfolioEvents = dashboardPortfolioEvents
        
        eventsDelegateManager = EventsDelegateManager(with: self)
    }
    
    // MARK: - Public methods
    func didSelectPortfolioEvents(at indexPath: IndexPath) {
        guard !viewModels.isEmpty else {
            return
        }
        
        let selectedModel = viewModels[indexPath.row]
        let event = selectedModel.dashboardPortfolioEvent
        if let assetId = event.assetId?.uuidString, let type = event.assetType, let assetType = AssetType(rawValue: type.rawValue) {
            router.showAssetDetails(with: assetId, assetType: assetType)
        }
    }
    
    func showAllPortfolioEvents() {
        router.show(routeType: .allEvents)
    }
}

extension EventListViewModel {
    // MARK: - Public methods
    /// Return view models for registration cell Nib files
    var cellModelsForRegistration: [CellViewAnyModel.Type] {
        return [PortfolioEventCollectionViewCellViewModel.self]
    }
    
    func modelsCount() -> Int {
        return viewModels.count
    }
    
    func numberOfSections() -> Int {
        return modelsCount() > 0 ? sections.count : 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return modelsCount()
    }
    
    func headerTitle(for section: Int) -> String? {
        return nil
    }
    
    func model(at indexPath: IndexPath) -> PortfolioEventCollectionViewCellViewModel? {
        return viewModels[indexPath.row]
    }
}
