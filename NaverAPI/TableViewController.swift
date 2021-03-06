//
//  TableViewController.swift
//  NaverAPI
//
//  Created by dochanghwan on 2022/07/06.
//

import UIKit
import os.log
import SafariServices

class TableViewController: UITableViewController, XMLParserDelegate {
    
    let posterImageQueue = DispatchQueue(label: "posterImage")
    
    let clientID = "B5HQrTioM1KLo6p91Pld"
    let clientSecret = "5aOv8ZFSGK"
    
    var queryText: String?
    var movies:[Movie] = []
    
    var strXMLData: String? = ""
    var currentTag: String? = ""
    var currentElement: String = ""
    var item: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // if let title = queryText {
      //      titleNavigationItem.title = title
      //  }
        searchMovies()
        // Do any additional setup after loading the view.
    }
    
    func searchMovies() {
        movies = []
        
        guard let query = queryText else {
            return
        }
        let urlString = "https://openapi.naver.com/v1/search/movie.xml?query=" + query
        let urlWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlWithPercentEscapes!)
        
        var request = URLRequest(url: url!)
        request.addValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 있으면 리턴
            guard error == nil else {
                print(error as Any)
                return
            }
            
            // 데이터가 비었으면 출력 후 리턴
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            // 데이터 초기화
            self.item?.actors = ""
            self.item?.director = ""
            self.item?.imageURL = ""
            self.item?.link = ""
            self.item?.pubDate = ""
            self.item?.title = ""
            self.item?.userRating = ""
            
            // Parse the XML
            let parser = XMLParser(data: Data(data))
            parser.delegate = self
            let success:Bool = parser.parse()
            if success {
                print(self.strXMLData as Any)
            } else {
                print("parse failure!")
            }
        }
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" || elementName == "link" || elementName == "image" || elementName == "pubDate" || elementName == "director" || elementName == "actor" || elementName == "userRating" {
            currentElement = ""
            if elementName == "title" {
                item = Movie()
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentElement += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            item?.title = currentElement.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        } else if elementName == "link" {
            item?.link = currentElement
        } else if elementName == "image" {
            item?.imageURL = currentElement
        } else if elementName == "pubDate" {
            item?.pubDate = currentElement
        } else if elementName == "director" {
            item?.director = currentElement
            if item?.director != "" {
                item?.director?.removeLast()
            }
        } else if elementName == "actor" {
            item?.actors = currentElement
            if item?.actors != "" {
                item?.actors?.removeLast()
            }
        } else if elementName == "userRating" {
            item?.userRating = currentElement
            movies.append(self.item!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellIdentifier", for: indexPath) as! MoviesTableViewCell
        let movie = movies[indexPath.row]
        guard let title = movie.title, let pubDate = movie.pubDate, let userRating = movie.userRating, let director = movie.director, let actor = movie.actors else {
            return cell
        }
        
        // 제목 및 개봉년도 레이블
        cell.titleAndYearLabel.text = "\(title)(\(pubDate))"
        
        // 평점 레이블
        if userRating == "0.00" {
            cell.userRatingLabel.text = "정보 없음"
        } else {
            cell.userRatingLabel.text = "\(userRating)"
        }
        
        // 감독 레이블
        if director == "" {
            cell.directorLabel.text = "정보 없음"
        } else {
            cell.directorLabel.text = "\(director)"
        }
        
        // 출연 배우 레이블
        if actor == "" {
            cell.actorsLabel.text = "정보 없음"
        } else {
            cell.actorsLabel.text = "\(actor)"
        }
        
        
        // Async activity
        // 영화 포스터 이미지 불러오기
        if let posterImage = movie.image {
            cell.posterImageView.image = posterImage
        } else {
            cell.posterImageView.image = UIImage(named: "noImage")
            posterImageQueue.async(execute: {
                movie.getPosterImage()
                guard let thumbImage = movie.image else {
                    return
                }
                DispatchQueue.main.async {
                    cell.posterImageView.image = thumbImage
                }
            })
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = movies[indexPath.row].link {
            if let url = URL(string: urlString) {
                let svc = SFSafariViewController(url: url)
                self.present(svc, animated: true, completion: nil)
            }
        }
    }
    
}


