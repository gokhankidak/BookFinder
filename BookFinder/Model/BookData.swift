//
//  BookData.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 13.11.2023.
//


struct BookVolume: Codable {
    let kind: String
    let totalItems: Int
    let items: [BookItem]
}

struct BookItem: Codable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let categories: [String]?
    let imageLinks: ImageLinks?
    let pageCount: Int?
    let language: String?
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
