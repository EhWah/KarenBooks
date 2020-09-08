//
//  OurPickCollectionViewCell.swift
//  Karen Digitial Library
//
//  Created by sowah on 9/8/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit

class OurPickCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var booktitle: UILabel!
  
    func configure(book: Book) {
        
        booktitle.text = book.bookTitleEnglish
    
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
