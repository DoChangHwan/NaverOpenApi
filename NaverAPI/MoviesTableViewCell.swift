//
//  MoviesTableViewCell.swift
//  NaverAPI
//
//  Created by dochanghwan on 2022/07/08.
//
import Foundation
import UIKit
import SnapKit

final class MoviesTableViewCell: UITableViewCell {
    static let identifier = "MoviesTableViewCell"
 //   @IBOutlet weak var titleAndYearLabel: UILabel!
 //   @IBOutlet weak var posterImageView: UIImageView!
 //   @IBOutlet weak var userRatingLabel: UILabel!
 //   @IBOutlet weak var directorLabel: UILabel!
 //   @IBOutlet weak var actorsLabel: UILabel!
    var titleAndYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var directorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
            $0.top.equalTo(titleAndYearLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().offset(-inset)
            $0.bottom.equalToSuperview().offset(-8.0)
        }
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(userRatingLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().offset(-inset)
            $0.bottom.equalToSuperview().offset(-8.0)
        }
        actorsLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(4.0)
            $0.trailing.equalToSuperview().offset(-inset)
            $0.bottom.equalToSuperview().offset(-8.0)
        }
    }
 }

