//
//  DashboardViewController.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 22.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class DashboardViewController: BaseViewController {

    // MARK: - View Model
    var viewModel: DashboardViewModel!

    // MARK: - Variables
    @IBOutlet var tableView: UITableView! {
        didSet {
            setupTableConfiguration()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private methods
    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.title
    }
    
    private func setupTableConfiguration() {
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
    }
}

extension DashboardViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    //DZNEmptyDataSetSource
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No data"
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor(.darkGray)]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let text = "Update"
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor(.blue)]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(.lightGray)
    }
    
    //DZNEmptyDataSetDelegate
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        //TODO: showProgressHUD()
        //TODO: pullToRefresh()
    }
}
