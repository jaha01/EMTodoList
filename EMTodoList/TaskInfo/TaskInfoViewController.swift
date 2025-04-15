//
//  TaskInfo.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 11.04.2025.
//

import UIKit

protocol TaskInfoViewControllerProtocol: AnyObject {
    func showTask(task: TodoItem)
}

final class TaskInfoViewController: UIViewController, TaskInfoViewControllerProtocol {
    
    // MARK: - Public Properties
    
    var interactor: TaskInfoInteractorProtocol!
    
    // MARK: - Private propeties
    
    private let titleTextField: UITextField = {
         let textField = UITextField()
         textField.font = UIFont.systemFont(ofSize: 28, weight: .bold)
         textField.textColor = .white
         textField.isUserInteractionEnabled = true
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
     }()

     private let dateTextField: UITextField = {
         let textField = UITextField()
         textField.font = UIFont.systemFont(ofSize: 16)
         textField.textColor = .lightGray
         textField.isUserInteractionEnabled = false
         textField.translatesAutoresizingMaskIntoConstraints = false
         return textField
     }()

     private let bodyTextView: UITextView = {
         let textView = UITextView()
         textView.font = UIFont.systemFont(ofSize: 18)
         textView.textColor = .white
         textView.backgroundColor = .clear
         textView.isScrollEnabled = true
         textView.isUserInteractionEnabled = true
         textView.translatesAutoresizingMaskIntoConstraints = false
         return textView
     }()

     override func viewDidLoad() {
         super.viewDidLoad()
         let backItem = UIBarButtonItem()
         backItem.title = "Назад"
         navigationItem.backBarButtonItem = backItem
         setupView()
         interactor.onLoad()
     }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            print("!!! - \(getCurrentFormattedDate())")
        }
    }

    // MARK: - Public methods
    
    func showTask(task: TodoItem) {
        titleTextField.text = ""
        dateTextField.text = ""
        bodyTextView.text = task.todo
    }
    
    // MARK: - Private methods
    
    private func getCurrentFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: Date())
    }
    
     private func setupView() {
         view.backgroundColor = .black
         navigationItem.title = ""
         navigationController?.navigationBar.tintColor = .systemYellow

         view.addSubview(titleTextField)
         view.addSubview(dateTextField)
         view.addSubview(bodyTextView)

         NSLayoutConstraint.activate([
             titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
             titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
             titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

             dateTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
             dateTextField.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
             dateTextField.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),

             bodyTextView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
             bodyTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
             bodyTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
             bodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
         ])
     }
 }
