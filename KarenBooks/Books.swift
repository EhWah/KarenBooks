//
//  Books.swift
//  KarenBooks
//
//  Created by sowah on 8/25/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import Foundation

struct Books: Codable {
    var books: [Book]
}

struct Book: Codable {
    var bookTitleEnglish: String
    var bookTitleKaren: String
    var bookAuthor: String
    var bookCategory: String
    var bookURL: String
    var bookCoverURL: String
}
