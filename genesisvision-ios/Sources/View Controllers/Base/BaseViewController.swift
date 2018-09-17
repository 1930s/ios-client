//
//  BaseViewController.swift
//  genesisvision-ios
//
//  Created by George Shaginyan on 16.01.18.
//  Copyright © 2018 Genesis Vision. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MessageUI

class BaseViewController: UIViewController, Hidable {
    var prefersLargeTitles: Bool = true {
        didSet {
            if #available(iOS 11.0, *) {
                navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        commonSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTheme()
    }
}

extension UIViewController {
    func updateTheme() {
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.BaseView.bg
        }

        setupNavigationBar()
        AppearanceController.applyTheme()
    }
    
    func commonSetup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
    }
    
    // MARK: - Public methods
    func setupNavigationBar(with type: NavBarType = .gray) {
        let colors = UIColor.NavBar.colorScheme(with: type)
        
        AppearanceController.setupNavigationBar(with: type)
        
        navigationController?.navigationBar.tintColor = colors.textColor
        navigationController?.navigationBar.backgroundColor = colors.backgroundColor
        navigationController?.navigationBar.barTintColor = colors.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: colors.textColor,
                                                                   NSAttributedStringKey.font: UIFont.getFont(.bold, size: 18)]
    }
}

extension UIViewController: MFMailComposeViewControllerDelegate {
    func sendEmailFeedback() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = configuredMailComposeViewController()
            present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    private func configuredMailComposeViewController() -> MFMailComposeViewController {
        let colors = UIColor.NavBar.colorScheme()
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([Constants.Urls.feedbackEmailAddress])
        mailComposerVC.setSubject(getFeedbackSubject())
        mailComposerVC.setMessageBody(getDeviceInfo(), isHTML: false)
        mailComposerVC.navigationBar.isTranslucent = false
        mailComposerVC.navigationBar.barTintColor = colors.backgroundColor
        mailComposerVC.navigationBar.tintColor = colors.tintColor
        mailComposerVC.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: colors.textColor,
                                                            NSAttributedStringKey.font: UIFont.getFont(.bold, size: 18)]
        return mailComposerVC
    }
    
    private func showSendMailErrorAlert() {
        showAlertWithTitle(title: String.Alerts.ErrorMessages.MailErrorAlert.title,
                           message: String.Alerts.ErrorMessages.MailErrorAlert.message,
                           actionTitle: nil,
                           cancelTitle: String.Alerts.ErrorMessages.MailErrorAlert.cancelButtonText,
                           handler: nil,
                           cancelHandler: nil)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

enum BottomViewType {
    case none, signIn, sort, filter, sortAndFilter, signInWithSortAndFilter
}
    
class BaseViewControllerWithTableView: BaseViewController, UIViewControllerWithTableView, UIViewControllerWithFetching {
    // MARK: - Veriables
    var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var fetchMoreActivityIndicator: UIActivityIndicatorView!
    var previousViewController: UIViewController?
    
    private var lastContentOffset: CGPoint = .zero
    
    var sortButton: ActionButton = {
        let btn = ActionButton(type: .system)
        btn.cornerSize = 18.0
        btn.bgColor = UIColor.BottomView.Sort.bg
        btn.tintColor = UIColor.BottomView.Sort.tint
        btn.translatesAutoresizingMaskIntoConstraints = true
        btn.setTitleColor(UIColor.BottomView.Sort.title, for: .normal)
        btn.setTitle("Sort by profit", for: .normal)
        btn.addTarget(self, action: #selector(sortButtonAction), for: .touchUpInside)
        return btn
    }()
    
    var filterButton: ActionButton = {
        let btn = ActionButton(type: .system)
        btn.bgColor = UIColor.BottomView.Filter.bg
        btn.cornerSize = 18.0
        btn.tintColor = UIColor.BottomView.Filter.tint
        btn.translatesAutoresizingMaskIntoConstraints = true
        btn.setTitleColor(UIColor.BottomView.Filter.title, for: .normal)
        btn.setImage(#imageLiteral(resourceName: "img_filters_icon"), for: .normal)
        btn.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        return btn
    }()
    
    var signInButton: ActionButton = {
        let btn = ActionButton(type: .system)
        btn.setTitle("SIGN IN", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = true
        btn.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private let sortAndFilterStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var bottomViewType: BottomViewType = .none {
        didSet {
            sortButton.isHidden = true
            filterButton.isHidden = true
            signInButton.isHidden = true
            bottomStackView.isHidden = false
            
            switch bottomViewType {
            case .none:
                bottomStackView.isHidden = true
            case .sort:
                sortButton.isHidden = false
            case .filter:
                filterButton.isHidden = false
            case .sortAndFilter:
                sortButton.isHidden = false
                filterButton.isHidden = false
            case .signIn:
                signInButton.isHidden = false
            case .signInWithSortAndFilter:
                signInButton.isHidden = false
                sortButton.isHidden = false
                filterButton.isHidden = false
            }
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addTableViewIfNeeded()
        setupViews()
        setupAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.delegate = self
    }
    
    // MARK: - Private methods
    private func addTableViewIfNeeded() {
        if tableView == nil {
            tableView = UITableView(frame: .zero, style: .plain)
            self.view.addSubview(tableView)
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
    
    private func setupViews() {
        tableView.separatorStyle = .none
        
        fetchMoreActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        fetchMoreActivityIndicator.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        fetchMoreActivityIndicator.color = UIColor.primary
        fetchMoreActivityIndicator.startAnimating()
        tableView.tableFooterView = fetchMoreActivityIndicator
        
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        
        tableView.separatorInset.left = 16.0
        tableView.separatorInset.right = 16.0
        
        tableView.backgroundColor = .clear
        
        refreshControl?.endRefreshing()
        
        sortAndFilterStackView.addArrangedSubview(sortButton)
        sortAndFilterStackView.addArrangedSubview(filterButton)
        bottomStackView.addArrangedSubview(signInButton)
        bottomStackView.addArrangedSubview(sortAndFilterStackView)
        
        view.addSubview(bottomStackView)
        
        bottomViewType = .none
    }
    
    private func setupAutoLayout() {
        sortButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 198).isActive = true
        
        filterButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        filterButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        signInButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 198).isActive = true
        
        sortAndFilterStackView.leftAnchor.constraint(equalTo: bottomStackView.leftAnchor, constant: 0).isActive = true
        sortAndFilterStackView.rightAnchor.constraint(equalTo: bottomStackView.rightAnchor, constant: 0).isActive = true
        sortAndFilterStackView.bottomAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 0).isActive = true
        sortAndFilterStackView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        bottomStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        bottomStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        if #available(iOS 11, *) {
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        } else {
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        }
        
    }
    
    
    // MARK: - Fetching
    func updateData() {
        showProgressHUD()
        fetch()
    }
    
    @objc func pullToRefresh() {
        impactFeedback()
    }
    
    func fetch() {
        //Fetch first page
    }
    
    func fetchMore() {
        //Fetch next page
    }
    
    func showInfiniteIndicator(value: Bool) {
        guard value, fetchMoreActivityIndicator != nil else {
            tableView.tableFooterView = UIView()
            return
        }
        
        fetchMoreActivityIndicator.startAnimating()
        tableView.tableFooterView = fetchMoreActivityIndicator
    }
    
    func hideAll() {
        hideHUD()
        refreshControl?.endRefreshing()
    }
    
    func setupPullToRefresh(title: String? = nil) {
        let tintColor = UIColor.primary
        let attributes = [NSAttributedStringKey.foregroundColor : tintColor]
        
        refreshControl = UIRefreshControl()
        if let title = title {
            refreshControl.attributedTitle = NSAttributedString(string: title, attributes: attributes)
        }
        refreshControl.tintColor = tintColor
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension BaseViewControllerWithTableView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset.y < scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.3) {
                self.sortAndFilterStackView.alpha = 0.0
            }
        } else if (self.lastContentOffset.y > scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.3) {
                self.sortAndFilterStackView.alpha = 1.0
            }
        }
    }
}

extension BaseViewControllerWithTableView: UIViewControllerWithBottomView {
    @objc func signInButtonAction() {
        
    }
    
    @objc func filterButtonAction() {
        
    }
    
    @objc func sortButtonAction() {
        
    }
}

extension BaseViewControllerWithTableView: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        guard previousViewController == viewController,
            let navController = viewController as? BaseNavigationController,
            let tabsType = TabsType(rawValue: tabBarIndex) else { return }
    
        switch tabsType {
        case .dashboard:
            if let vc = navController.viewControllers.first as? DashboardViewController, let tableView = vc.tableView {
                scrollTop(tableView: tableView)
            }
        case .programList:
            if let vc = navController.viewControllers.first as? ProgramListViewController, let tableView = vc.tableView {
                scrollTop(tableView: tableView)
            }
        case .wallet:
            if let vc = navController.viewControllers.first as? WalletViewController, let tableView = vc.tableView {
                scrollTop(tableView: tableView)
            }
        case .profile:
            if let vc = navController.viewControllers.first as? ProfileViewController, let tableView = vc.tableView {
                scrollTop(tableView: tableView)
            }
        }
    }
    
    func scrollTop(tableView: UITableView) {
        tableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        previousViewController = tabBarController.selectedViewController
        return true
    }
}

// MARK: - EmptyData
extension BaseViewControllerWithTableView: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = ""
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.Font.dark,
                          NSAttributedStringKey.font : UIFont.getFont(.bold, size: 25)]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        fetchMoreActivityIndicator.stopAnimating()
        return 40
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.noDataPlaceholder
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.BaseView.bg
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        updateData()
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> UIImage! {
        let capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0)
        let rectInsets = UIEdgeInsetsMake(0, -20, 0.0, -20)
        var image: UIImage = #imageLiteral(resourceName: "img_button")
        
        if state == .highlighted {
            image = #imageLiteral(resourceName: "img_button_highlighted")
        }
        
        return image.resizableImage(withCapInsets: capInsets, resizingMode: .stretch).withAlignmentRectInsets(rectInsets)
    }
}

class BaseTableViewController: UITableViewController, UIViewControllerWithFetching, Hidable {
    // MARK: - Variables
    var fetchMoreActivityIndicator: UIActivityIndicatorView!
    
    var prefersLargeTitles: Bool = true {
        didSet {
            if #available(iOS 11.0, *) {
                navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonSetup()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTheme()
    }
    
    // MARK: - Fetching
    func updateData() {
        showProgressHUD()
        fetch()
    }
    
    @objc func pullToRefresh() {
        impactFeedback()
    }
    
    func fetch() {
        //Fetch first page
    }
    
    func fetchMore() {
        //Fetch next page
    }
    
    func showInfiniteIndicator(value: Bool) {
        guard value, fetchMoreActivityIndicator != nil else {
            tableView.tableFooterView = UIView()
            return
        }
        
        fetchMoreActivityIndicator.startAnimating()
        tableView.tableFooterView = fetchMoreActivityIndicator
    }
    
    func hideAll() {
        hideHUD()
        refreshControl?.endRefreshing()
    }
    
    func setupPullToRefresh(title: String? = nil) {
        let tintColor = UIColor.primary
        let attributes = [NSAttributedStringKey.foregroundColor : tintColor]
        
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        if let title = title {
            tableView.refreshControl?.attributedTitle = NSAttributedString(string: title, attributes: attributes)
        }
        tableView.refreshControl?.tintColor = tintColor
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    func setupViews() {
        tableView.separatorStyle = .none
        
        fetchMoreActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        fetchMoreActivityIndicator.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        fetchMoreActivityIndicator.color = UIColor.primary
        fetchMoreActivityIndicator.startAnimating()
        tableView.tableFooterView = fetchMoreActivityIndicator
        
        tableView.backgroundColor = .clear
        
        tableView.separatorInset.left = 16.0
        tableView.separatorInset.right = 16.0
        
        refreshControl?.endRefreshing()
    }
}
