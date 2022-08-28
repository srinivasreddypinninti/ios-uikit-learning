//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by srinivas on 27/08/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var accounts:[AccountSummaryCell.ViewModel] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseId)
        tableView.rowHeight = AccountSummaryCell.rowHeigth
//        tableView.tableFooterView = UIView()
        
        
    }
    
    private func setupTableHeaderView() {
        
        let header = AccountSummaryHeaderView(frame: .zero)
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
        
    }
}

// MARK: - Datasource
extension AccountSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseId, for: indexPath) as? AccountSummaryCell else {
            fatalError("dequeueReusableCell failed ")
        }
        cell.configure(accounts[indexPath.row])
        return cell
    }
}

// MARK: - Delegate
extension AccountSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
}

extension AccountSummaryViewController {
    
    private func fetchData() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings")
        let visa = AccountSummaryCell.ViewModel(accountType: .CrediCard, accountName: "Visa Avion Card")
        let investment = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver")
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
    }
}
