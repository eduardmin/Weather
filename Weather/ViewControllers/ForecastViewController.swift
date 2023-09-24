//
//  ForecastViewController.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import UIKit

class ForecastViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ForecastViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.title = "Forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTableViewCell")
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecast?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        cell.configure(temp: viewModel.temperature(indexPath: indexPath), icon: viewModel.weatherIcon(indexPath: indexPath))
        cell.selectionStyle = .none
        return cell
    }
}

