//
//  File.swift
//  NaverAPI
//
//  Created by dochanghwan on 2022/07/08.
//

import Foundation
import UIKit

class Movie {
    var title:String?
    var link:String?
    var imageURL:String?
    var image:UIImage?
    var pubDate:String?
    var director:String?
    var actors:String?
    var userRating:String?
    init() {
    }
    func getPosterImage() {
        guard imageURL != nil else {
            return
        }
        if let url = URL(string: imageURL!) {
            if let imgData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imgData) {
                    self.image = image
                }
            }
        }
        return
    }
}
