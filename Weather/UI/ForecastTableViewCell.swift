//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        mainView.layer.cornerRadius = 8
    }
    
    func configure(temp: String?, icon: String?) {
        tempLabel.text = temp
        tempImageView.image = UIImage(named: icon ?? "")
    }
}
