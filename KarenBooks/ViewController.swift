//
//  ViewController.swift
//  KarenBooks
//
//  Created by sowah on 8/24/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import UIKit
import PDFReader

struct Books {
    let title: String
    let subtitle: String
    let pdfLink: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var books = [
        Books(title: "The Bronze Drum and the Karen", subtitle: "ကျိၣ်ဒီးကညီဖိ", pdfLink: "https://www.drumpublications.org/download/karendrum_k.pdf"),
        Books(title: "Hta and the Karen Way of Life ", subtitle: "ပှၤကညီအလုၢ်ဖိထါဖိဒီးတၢ်တဲယုၤတဖၣ်", pdfLink: "https://www.drumpublications.org/download/traditionalkarencloth.pdf"),
    Books(title: "Karen History and Traditional Judicial System", subtitle: "ကညီတၢ်စံၣ်စိၤတဲစိၤဒီးလုၢ်လၢ်ထူသနူ", pdfLink: "https://www.drumpublications.org/download/karenhistoryk.pdf")]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookTableViewCell
        cell.bookEnglishTitle.text = books[indexPath.row].title
        cell.bookKarenTitle.text = books[indexPath.row].subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let remotePDFDocumentURL = URL(string: books[indexPath.row].pdfLink)!
        let document = PDFDocument(url: remotePDFDocumentURL)!
        
        let readerController = PDFViewController.createNew(with: document)
        readerController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(readerController, animated: true)
    }
}

