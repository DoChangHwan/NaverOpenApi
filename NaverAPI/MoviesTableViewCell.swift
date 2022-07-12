//
//  MoviesTableViewCell.swift
//  NaverAPI
//
//  Created by dochanghwan on 2022/07/08.
//
import Foundation
import UIKit
import SnapKit

class MoviesTableViewCell: UITableViewCell {
    
 //   @IBOutlet weak var titleAndYearLabel: UILabel!
 //   @IBOutlet weak var posterImageView: UIImageView!
 //   @IBOutlet weak var userRatingLabel: UILabel!
 //   @IBOutlet weak var directorLabel: UILabel!
 //   @IBOutlet weak var actorsLabel: UILabel!
    private lazy var titleAndYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    func setupCell(title: String, putDate: String) {
        setupViews()
        titleAndYearLabel.text = title.htmlToString
    
        
    }
    
    
private extension MoviesTableViewCell {
    func setupViews() {
        [
            titleAndYearLabel,
            userRatingLabel,
            directorLabel,
            actorsLabel
        ]
            .forEach {
                contentView.addSubview($0)
            }

        let inset: CGFloat = 16.0
        titleAndYearLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8.0)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().offset(-inset)
        }

        userRatingLabel.snp.makeConstraints {
            $0.top.equalTo(newsTitleLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().offset(-inset)
            $0.bottom.equalToSuperview().offset(-8.0)
        }
    }
}
