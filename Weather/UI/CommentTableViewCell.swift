//
//  CommentTableViewCell.swift
//  Weather
//
//  Created by Eduard Minasyan on 24.09.23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        mainView.layer.cornerRadius = 8
    }
    
    func configure(comment: CommentModel) {
        commentLabel.text = comment.message
    }
}
