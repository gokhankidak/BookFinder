//
//  BookSearchVC.swift
//  BookFinder
//
//  Created by Gökhan Kıdak on 13.11.2023.
//

import SwiftUI
import SnapKit

final class BookSearchVC : UIViewController, ResultTableViewOutput{
    private let resultTableView = ResultTableView()
    private let bookDetailVC = BookDetailVC()
    private let bookFinderVM : BookFinderViewModelProtocol = BookFinderViewModel()
    
    private let bookFinderLabel = UILabel()
    private let searchTextField = UITextField()
    private let resultTableViewPlaceHolder = UITableView()
    
    private let horizontalOffset : CGFloat = 40
    private let labelTopOffset: CGFloat = 20
    private let labelHeight: CGFloat = 100
    private let minorOffset : CGFloat = 10
    private let searchBarHeight :CGFloat = 50
    
    var delegate : ResultTableViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        searchTextField.delegate = self
        resultTableViewPlaceHolder.delegate = resultTableView
        resultTableViewPlaceHolder.dataSource = resultTableView
        resultTableView.delegate = self
    }
    
    func configUI(){
        view.addSubview(bookFinderLabel)
        makeLabel()
        view.addSubview(searchTextField)
        makeSearchBar()
        view.addSubview(resultTableViewPlaceHolder)
        makeResultTableView()
    }
    
    private func makeLabel() {
        let headerFont = UIFont(name: "Chalkduster", size: labelHeight)
        
        bookFinderLabel.text = "Book Finder"
        bookFinderLabel.textColor = .orange
        bookFinderLabel.font = headerFont
        bookFinderLabel.textAlignment = .center
        bookFinderLabel.adjustsFontSizeToFitWidth = true
        
        bookFinderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(labelTopOffset)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-horizontalOffset)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(horizontalOffset)
            make.height.equalTo(labelHeight)
        }
    }
    
    private func makeSearchBar() {
        searchTextField.placeholder = "Type author, book name, subject etc..."
        searchTextField.borderStyle = .roundedRect
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(bookFinderLabel.snp.bottom).offset(minorOffset)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-horizontalOffset)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(horizontalOffset)
            make.height.equalTo(searchBarHeight)
        }
    }
    
    private func makeResultTableView() {
        resultTableViewPlaceHolder.backgroundColor = .white
        resultTableViewPlaceHolder.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(minorOffset * 2)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-minorOffset)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(minorOffset)
        }
        resultTableViewPlaceHolder.register(BookCell.self, forCellReuseIdentifier: "bookCell")
        resultTableViewPlaceHolder.rowHeight = 150
        resultTableViewPlaceHolder.isHidden = true
    }
    
    //MARK: Result table
    func onSelected(index : Int) {
        let volumeInfo = bookFinderVM.bookItems[index].volumeInfo
        bookDetailVC.setView(item : volumeInfo)
        present(bookDetailVC, animated: true)
    }
    
    func fetchItems(search : String){
        bookFinderVM.fetchItem(search: search,response: { items in
            self.resultTableView.update(items: items)
            self.resultTableViewPlaceHolder.reloadData()
        })
    }
}

extension BookSearchVC : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resultTableViewPlaceHolder.isHidden = true
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if searchTextField.text == "" { return true}
        
        resultTableViewPlaceHolder.isHidden = false
        fetchItems(search: searchTextField.text ?? "")
        
        return true
    }
    //end editing when touched outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
