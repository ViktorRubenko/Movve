//
//  FavoritesViewController.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class FavoritesViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: FavoritesPresenterInterface!
    
    // MARK: - Private properties -
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: presenter.segments)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        return sc
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        return tv
    }()
    
    private let emptyBackgroundView = EmptyBackgroundView(
        image: UIImage(systemName: "bookmark"),
        topText: "Favorites",
        bottomText: "You don't have any favorites."
    )

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationAppearance()
        presenter.loadData()
    }
}

private extension FavoritesViewController {
    func setupViews() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .appBackground
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(safeArea)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.insertSubview(emptyBackgroundView, at: 0)
        emptyBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    func showEmptyView() {
        emptyBackgroundView.isHidden = !presenter.items.isEmpty
    }
    
    func setupNavigationItem() {
        navigationItem.title = "Favorites"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapSortButton)
        )
    }
    
    func setupNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .appBackground.withAlphaComponent(0.95)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Actions -
    
    @objc func didChangeSegment() {
        presenter.didSelectSegment(index: segmentedControl.selectedSegmentIndex)
    }

    @objc func didTapSortButton() {
        let alert = UIAlertController(title: "Sort By", message: nil, preferredStyle: .alert)
        presenter.sortOptions.forEach { value in
            alert.addAction(UIAlertAction(title: value, style: .default, handler: { _ in
                self.presenter.didSelectSort(by: value)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - Extensions -

extension FavoritesViewController: FavoritesViewInterface {
    func reloadData() {
        showEmptyView()
        tableView.reloadData()
    }
    
    func removeItem(at indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
        showEmptyView()
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.item(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.configure(item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.swapToRemove(indexPath: indexPath)
        }
    }
}
