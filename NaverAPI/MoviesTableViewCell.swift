//
//  MoviesTableViewCell.swift
//  NaverAPI
//
//  Created by dochanghwan on 2022/07/08.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleAndYearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
