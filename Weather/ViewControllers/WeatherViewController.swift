//
//  WeatherViewController.swift
//  Weather
//
//  Created by Eduard Minasyan on 24.09.23.
//

import UIKit

class WeatherViewController: BaseViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherTemperature: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let rightButton = UIButton()
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.update()
    }
    
    override func bindViewModel() {
        viewModel.$state.sink { [unowned self] object in
            DispatchQueue.main.async {
                switch object {
                case .loading:
                    self.startLoading()
                case .error:
                    self.showEmptyView()
                case .notLoaded:
                    self.stopLoading()
                case .loaded:
                    self.stopLoading()
                    self.handleSuccess()
                }
            }
        }.store(in: &cancellables)
    }
    
    private func configureUI() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureRightButton()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
    }
    
    private func configureRightButton() {
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "city"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(rightButton)
        rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 120, height: 20)
        
        let targetView = self.navigationController?.navigationBar
        
        let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
                                                        .trailingMargin, relatedBy: .equal, toItem: targetView,
                                                   attribute: .trailingMargin, multiplier: 1.0, constant: -16)
        let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                                  toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -16)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
    }
    
    private func showEmptyView() {
        addEmptyView(title: "No Access", description: "I apologize, but it appears that location services are currently disabled or not permitted for your account. To enable location services or if you have any questions about why location access is restricted, please check your device settings or reach out to our support team for further assistance. We're here to help with any concerns you may have.")
    }
    
    func configure() {
        cityLabel.text = viewModel.getCityName()
        if let icon = viewModel.weatherIcon() {
            currentWeatherIcon.image = UIImage(named: icon)
        }
        currentWeatherTemperature.text = viewModel.temperature()
    }
    
    @objc func rightAction() {
        let alert = UIAlertController(title: "Change City", message: "You can write your desired city", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "City Name"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if let text = textField?.text, !text.isEmpty {
                self.viewModel.getWeather(cityName: text)
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController {
    func handleSuccess() {
        configure()
        tableView.reloadData()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        if let comment = viewModel.comments()?[indexPath.row] {
            cell.configure(comment: comment)
        }
        cell.selectionStyle = .none
        return cell
    }
}
