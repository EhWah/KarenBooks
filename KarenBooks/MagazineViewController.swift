//
//  MagazineViewController.swift
//  Karen Digitial Library
//
//  Created by sowah on 9/7/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import Alamofire

class MagazineViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
     var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        requestJson()
    }

    func requestJson() {
        
        AF.request("https://raw.githubusercontent.com/EhWah/Karen-Library/master/jsonData.json").response { (response) in
            if let JSON = response.data {
                self.parse(json: JSON)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let json = try? decoder.decode(Books.self, from: json) {
            json.books.forEach { (book) in
                if book.bookCategory == "Magazine" {
                    self.books.append(book)
                }
            }
        }
        collectionView.reloadData()
    }
}

extension MagazineViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "magazineCell", for: indexPath) as! MagazineCollectionViewCell
        cell.configure(book: books[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webReaderController = WebViewController()
        webReaderController.magazineUrl = books[indexPath.row].bookURL
        webReaderController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(webReaderController, animated: true)
    }
    
}
