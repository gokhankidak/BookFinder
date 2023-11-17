//
//  BookDetailView.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 15.11.2023.
//

import UIKit
import SnapKit

final class BookDetailVC : UIViewController
{
    private let scroolView = UIScrollView()
    
    private let coverImage = UIImageView()
    private let titleLabel = UILabel()
    private let authorHeaderLabel = UILabel()
    private let authorLabel = UILabel()
    private let publisherHeaderLabel = UILabel()
    private let publisherLabel = UILabel()
    private let publishedDateHeaderLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let pagesHeaderLabel = UILabel()
    private let pagesLabel = UILabel()
    private let descriptionHeaderLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let lineSpace = 5
    private let offsetSpace = 10
    private let infoFontSize : CGFloat = 18
    private let titleFontSize : CGFloat = 20
    private let headerFont = UIFont.boldSystemFont(ofSize: 18)
    
    
    public func setView(item : VolumeInfo)
    {
        configUI()
        
        let http = item.imageLinks?.thumbnail ?? ""
        let https = "https" + http.dropFirst(4)
        
        coverImage.kf.setImage(with: URL(string:https),placeholder : UIImage.default)
        titleLabel.text = item.title
        authorLabel.text = item.authors?[0]
        publisherLabel.text = item.publisher
        publishedDateLabel.text = item.publishedDate
        pagesLabel.text = String(item.pageCount ?? 0)
        descriptionLabel.text = item.description
        descriptionLabel.numberOfLines = 0
    }
    
    private func configUI(){
        
        //MARK: Subview assignment
        
        view.addSubview(scroolView)
        scroolView.addSubview(coverImage)
        scroolView.addSubview(titleLabel)
        
        authorHeaderLabel.addSubview(authorLabel)
        scroolView.addSubview(authorHeaderLabel)
        
        publisherHeaderLabel.addSubview(publisherLabel)
        scroolView.addSubview(publisherHeaderLabel)
        
        publishedDateHeaderLabel.addSubview(publishedDateLabel)
        scroolView.addSubview(publishedDateHeaderLabel)
        
        pagesHeaderLabel.addSubview(pagesLabel)
        scroolView.addSubview(pagesHeaderLabel)
        
        descriptionHeaderLabel.addSubview(descriptionLabel)
        scroolView.addSubview(descriptionHeaderLabel)
        
        //MARK: Autolayout
        
        scroolView.backgroundColor = .white
        scroolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        makeTitle()
        makeCoverImage()
        makeAuthor()
        makePublisher()
        makePublishedDates()
        makePages()
        makeDescription()
    }
    
    private func makeDescription() {
        //MARK: Descripton
        descriptionHeaderLabel.text = "Description : "
        descriptionHeaderLabel.font = headerFont
        descriptionHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImage.snp.bottom)
            make.trailing.equalTo(scroolView.snp.trailing).offset(-offsetSpace)
            make.leading.equalTo(coverImage.snp.leading)
        }
        setSubLabel(headerLabel : descriptionHeaderLabel, subLabel: descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(scroolView.snp.bottom)
        }
    }
    
    private func makePages() {
        //MARK: Pages
        pagesHeaderLabel.text = "Pages : "
        pagesHeaderLabel.font = headerFont
        pagesHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(publishedDateLabel.snp.bottom).offset(lineSpace)
            make.leading.equalTo(publishedDateLabel.snp.leading)
            make.height.equalTo(infoFontSize)
        }
        setSubLabel(headerLabel : pagesHeaderLabel, subLabel: pagesLabel)
    }
    
    private func makePublishedDates() {
        //MARK: Published Date
        publishedDateHeaderLabel.text = "Published Date : "
        publishedDateHeaderLabel.font = headerFont
        publishedDateHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(lineSpace)
            make.leading.equalTo(publisherLabel.snp.leading)
            make.height.equalTo(infoFontSize)
        }
        setSubLabel(headerLabel : publishedDateHeaderLabel, subLabel: publishedDateLabel)
    }
    
    private func makePublisher() {
        //MARK: Publisher
        publisherHeaderLabel.text = "Publisher : "
        publisherHeaderLabel.font = headerFont
        publisherHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(lineSpace)
            make.leading.equalTo(authorLabel.snp.leading)
            make.height.equalTo(infoFontSize)
        }
        setSubLabel(headerLabel : publisherHeaderLabel, subLabel: publisherLabel)
    }
    
    private func makeAuthor() {
        //MARK: Author
        authorHeaderLabel.text = "Author : "
        authorHeaderLabel.font = headerFont
        authorHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImage.snp.top)
            make.leading.equalTo(coverImage.snp.trailing).offset(lineSpace)
            make.height.equalTo(infoFontSize)
        }
        setSubLabel(headerLabel : authorHeaderLabel, subLabel: authorLabel)
    }
    
    private func makeCoverImage() {
        //MARK: Cover image
        coverImage.image = .default
        coverImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(lineSpace)
            make.leading.equalToSuperview().offset(offsetSpace)
            make.height.equalTo(240)
            make.width.equalTo(150)
        }
    }
    
    private func makeTitle() {
        //MARK: Title
        titleLabel.text = "title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(offsetSpace)
            make.leading.equalToSuperview().offset(offsetSpace)
            make.trailing.equalTo(view.snp.trailing).offset(-offsetSpace)
            make.height.equalTo(titleFontSize)
        }
    }
    
    // add constraints to infos to replace their headers bottom
    private func setSubLabel(headerLabel : UILabel,subLabel : UILabel){
        subLabel.lineBreakMode = .byTruncatingTail
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(lineSpace)
            make.trailing.equalTo(view.snp.trailing).offset(-offsetSpace)
            make.leading.equalTo(headerLabel.snp.leading)
        }
    }
    
}
