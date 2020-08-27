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
import ProgressHUD

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
        ProgressHUD.show()
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorAnimation = .orange
        
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
        ProgressHUD.dismiss()
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        cell.layer.zPosition = CGFloat(1000 - indexPath.row)
        cell.configure(book: books[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let remotePDFDocumentURL = URL(string: books[indexPath.row].bookURL) {
            
            if let document = PDFDocument(url: remotePDFDocumentURL) {
                
                let readerController = PDFViewController.createNew(with: document, title: books[indexPath.row].bookTitleEnglish, actionButtonImage: nil, actionStyle: .activitySheet, backButton: nil, isThumbnailsEnabled: true, startPageIndex: 0)
                
                ProgressHUD.showSucceed()
                ProgressHUD.colorAnimation = .orange
                
                readerController.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(readerController, animated: true)
            } else {
                ProgressHUD.showFailed()
            }
            
            
            
        } else {
           
            ProgressHUD.showFailed()
            ProgressHUD.colorAnimation = .orange
        }
        
        
        
    }
}

