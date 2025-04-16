//
//  ViewController.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 09.04.2025.
//

import UIKit

protocol TasksViewControllerProtocol: AnyObject {
    func showTasks(tasks: [Task])
}

final class TasksViewController: UIViewController, TasksViewControllerProtocol, UISearchBarDelegate {
    
    // MARK: - Public Properties
    
    var interactor: TasksInteractorProtocol!
    
    // MARK: - Private properties
    
    private var tasks = [Task]()
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
        addButton.addTarget(self, action: #selector(createTask), for: .touchUpInside)
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
    
    func showTasks(tasks: [Task]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.tasks = tasks
            self.tableView.reloadData()
            self.tasksCountLabel.text = "\(tasks.count) Задач"
        }
    }
    
    // MARK: - Private properties
    
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
    
    @objc private func createTask() {
        let alert = UIAlertController(title: "Новая задача", message: "", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Заголовок"
        }

        alert.addTextField { textField in
            textField.placeholder = "Описание"
        }

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            
            let titleText = alert.textFields?[0].text ?? ""
            let descriptionText = alert.textFields?[1].text ?? ""

            self.interactor.saveTask(task: Task(id: 0,
                                                title: titleText,
                                                taskDescription: descriptionText,
                                                isCompleted: false,
                                                date: Date()))
        }))

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }),
           let rootVC = window.rootViewController {
               rootVC.present(alert, animated: true, completion: nil)
        }
    }
}


extension TasksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: taskCell, for: indexPath) as! TaskCell
        cell.configure(with: tasks[indexPath.row])
        
        cell.onCheckTapped = { [weak self] in
            guard let self = self else { return }
            self.interactor.changeTaskStatus(self.tasks[indexPath.row].id)
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.goToTaskInfo(task: tasks[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.deleteTask(id: tasks[indexPath.row].id)
        }
    }
}
