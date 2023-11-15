//
//  BookCell.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 13.11.2023.
//

import SwiftUI
import SnapKit

class BookCell : UITableViewCell{
    
    let titleLabel = UILabel()
    let coverImage = UIImageView()
    let authorLabel = UILabel()
    let publisherLabel = UILabel()
    let publishedYearLabel = UILabel()
    
    let borderOffset = 10
    let labelHeight = 20
    let spaceFromImage = 30
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(coverImage)
        addSubview(authorLabel)
        addSubview(publisherLabel)
        addSubview(publishedYearLabel)
        
        titleLabel.text = "Unkown"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
    
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(borderOffset)
            make.height.equalTo(labelHeight)
            make.leading.equalToSuperview().offset(borderOffset)
            make.trailing.equalToSuperview().offset(-borderOffset)
        }
        
        coverImage.image = UIImage(systemName: "heart.fill")
        coverImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(borderOffset)
            make.bottom.equalToSuperview().offset(-borderOffset)
            make.leading.equalToSuperview().offset(borderOffset)
            make.width.equalTo(coverImage.snp.height)
        }
        
        authorLabel.text = "Author : Unkown"
        authorLabel.numberOfLines = 1
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(borderOffset * 4)
            make.leading.equalTo(coverImage.snp.trailing).offset(spaceFromImage)
            make.height.equalTo(labelHeight)
        }
        
        publisherLabel.text = "Publisher : Unkown"
        publisherLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(borderOffset)
            make.leading.equalTo(coverImage.snp.trailing).offset(spaceFromImage)
            make.height.equalTo(authorLabel.snp.height)
        }
        
        publishedYearLabel.text = "Year : 0000"
        publishedYearLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom)
            make.leading.equalTo(coverImage.snp.trailing).offset(spaceFromImage)
            make.height.equalTo(authorLabel.snp.height)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
