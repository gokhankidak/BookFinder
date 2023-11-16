//
//  ResultTableView.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 14.11.2023.
//

import SwiftUI
import Kingfisher

protocol ResultTableViewProtocol{
    func update(items : [BookItem])
}

protocol ResultTableViewOutput : AnyObject{
    func onSelected(_ info : VolumeInfo)
}

final class ResultTableView : NSObject,ResultTableViewProtocol{
    
    lazy var items : [BookItem]  = []
    
    func update(items: [BookItem]) {
        self.items = items

    }
    
    weak var delegate : ResultTableViewOutput?
}

extension ResultTableView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell
        let item = items[indexPath.row].volumeInfo
        cell.titleLabel.text = item.title
        
        let http = item.imageLinks?.thumbnail ?? "http://"
        let https = "https" + http.dropFirst(4)
        
        cell.coverImage.kf.setImage(with: URL(string:https),placeholder: UIImage.default)
        cell.publishedYearLabel.text = item.publishedDate
        cell.publisherLabel.text = item.publisher
        
        var authors : String { var value = ""
            for author in item.authors ?? []{
                value.append(author)
                value.append(",")
            }
            return value
        }
        
        cell.authorLabel.text = authors
        return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(items[indexPath.row].volumeInfo)
    }
}
