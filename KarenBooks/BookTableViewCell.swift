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
    @IBOutlet weak var bookCategory: UILabel!
    @IBOutlet weak var bookFrom: UILabel!
    

    func configure(book: Book) {
        
        bookEnglishTitle.text = book.bookTitleEnglish
        bookKarenTitle.text = book.bookTitleKaren
        bookCategory.text = book.bookCategory
        bookFrom.text = "From: \(book.bookAuthor)"
        
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
    
    override func awakeFromNib() {
        
        containerview.layer.cornerRadius = 4
        containerview.layer.shadowOpacity = 0.1
        containerview.layer.shadowOffset = CGSize(width: 1, height: 10)
        containerview.layer.shadowRadius = 15
        
    }
}
