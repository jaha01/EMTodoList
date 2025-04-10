//
//  ViewController.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 09.04.2025.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    func showTasks(tasks: [TodoItem], tasksCount: Int)
}

final class ViewController: UIViewController, ViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Public Properties
    
    var interactor: InteractorProtocol!
    
    // MARK: - Private properties
    
    private var tasks = [TodoItem]()
    private let taskCell = "TaskCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: taskCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let bottomBar: UIView = {
        let bottomBar = UIView()
        bottomBar.backgroundColor = .black
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        return bottomBar
    }()
        
    private let tasksCountLabel: UILabel = {
        let tasksCountLabel = UILabel()
        tasksCountLabel.textColor = .white
        tasksCountLabel.font = UIFont.systemFont(ofSize: 16)
        tasksCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return tasksCountLabel
    }()
    
    private let addButton: UIButton = {
        let addButton = UIButton(type: .system)
        addButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        addButton.tintColor = .yellow
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let largeTitleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitleAttributes
        
        setup()
        interactor.load()
    }
    
    // MARK: - Public properties
    
    func showTasks(tasks: [TodoItem], tasksCount: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.tasks = tasks
            self.tableView.reloadData()
            self.tasksCountLabel.text = "\(tasksCount) Задач"
        }
    }
    
    private func setup() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(bottomBar)
        bottomBar.addSubview(tasksCountLabel)
        bottomBar.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            
            bottomBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 60),
            
            tasksCountLabel.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            tasksCountLabel.centerXAnchor.constraint(equalTo: bottomBar.centerXAnchor),
            
            addButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: taskCell, for: indexPath) as! TaskCell
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
