//
//  BookForChildrenCollectionViewCell.swift
//  Karen Digitial Library
//
//  Created by sowah on 9/9/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit

class BookForChildrenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    
    func configure(book: Book) {
        
        bookTitle.text = book.bookTitleEnglish
    
        if let url = URL(string: book.bookCoverURL) {
            bookCover.af.setImage(withURL: url)
        } else {
            bookCover.image = UIImage(named: "notAvailable")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookCover.af.cancelImageRequest()
        bookCover.image = nil
    }
}
