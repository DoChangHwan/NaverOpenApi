//
//  MoviesTableViewCell.swift
//  NaverAPI
//
//  Created by dochanghwan on 2022/07/08.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
 //   @IBOutlet weak var titleAndYearLabel: UILabel!
 //   @IBOutlet weak var posterImageView: UIImageView!
 //   @IBOutlet weak var userRatingLabel: UILabel!
 //   @IBOutlet weak var directorLabel: UILabel!
 //   @IBOutlet weak var actorsLabel: UILabel!
    private lazy var titleAndYearLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var userRatingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var actorsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
