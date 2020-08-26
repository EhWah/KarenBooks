//
//  ViewController.swift
//  KarenBooks
//
//  Created by sowah on 8/24/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import PDFReader
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        
        cell.configure(book: books[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let remotePDFDocumentURL = URL(string: books[indexPath.row].bookURL) {
            if let document = PDFDocument(url: remotePDFDocumentURL) {
                let readerController = PDFViewController.createNew(with: document, title: books[indexPath.row].bookTitleKaren, actionButtonImage: nil, actionStyle: .activitySheet, backButton: nil, isThumbnailsEnabled: true, startPageIndex: 0)
                readerController.navigationItem.largeTitleDisplayMode = .never
                
                navigationController?.pushViewController(readerController, animated: true)
            }
        }
        
        print("no url")
        
    }
}

