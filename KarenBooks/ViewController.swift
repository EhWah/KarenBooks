//
//  ViewController.swift
//  KarenBooks
//
//  Created by sowah on 8/24/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import PDFReader

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locateJsonFile()
    }
    
    func locateJsonFile() {
        // locate the json file in project
        // ကွၢ်ဃု json file လၢပ project အပူၤ
        
        let urlString = "https://raw.githubusercontent.com/EhWah/Karen-Library/master/jsonData.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                parse(json: data)
            }
        }
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let json = try? decoder.decode(Books.self, from: json) {
            books.append(contentsOf: json.books)
        }
        tableView.reloadData()
    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        cell.bookEnglishTitle.text = books[indexPath.row].bookTitleKaren
//        cell.bookKarenTitle.text = books[indexPath.row].bookCategory
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let remotePDFDocumentURL = URL(string: books[indexPath.row].bookCategory)!
//        let document = PDFDocument(url: remotePDFDocumentURL)!
//        
//        let readerController = PDFViewController.createNew(with: document, title: books[indexPath.row].bookTitleKaren, actionButtonImage: nil, actionStyle: .activitySheet, backButton: nil, isThumbnailsEnabled: true, startPageIndex: 0)
//        readerController.navigationItem.largeTitleDisplayMode = .never
//        
//        navigationController?.pushViewController(readerController, animated: true)
//    }
}

