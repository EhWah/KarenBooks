//
//  BookTableViewCell.swift
//  KarenBooks
//
//  Created by sowah on 8/25/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var containerview: UIView!
    @IBOutlet weak var bookEnglishTitle: UILabel!
    @IBOutlet weak var bookKarenTitle: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
   

    func configure(book: Book) {
        bookEnglishTitle.text = book.bookTitleEnglish
        bookKarenTitle.text = book.bookTitleKaren
        
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
