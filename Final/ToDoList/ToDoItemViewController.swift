//
//  ToDoItemViewController.swift
//  ToDoList
//
//  Created by Lucy Xu on 8/21/20.
//  Copyright © 2020 flick. All rights reserved.
//

import UIKit

class ToDoItemViewController: UIViewController {

    private let bannerView = UIView()
    private let todoTableView = UITableView(frame: .zero, style: .plain)
    private let todoTextField = UITextField()
    private var todoItem: ToDo!
    private let todoTitle = UILabel()
    private let submitButton = UIButton()

    private let todoCellReuseIdentifier = "TodoCellReuseIdentifier"

    init(todoItem: ToDo) {
        super.init(nibName: nil, bundle: nil)
        self.todoItem = todoItem
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.backgroundColor = UIColor(red: 32/255, green: 171/255, blue: 211/255, alpha: 1)
        view.addSubview(bannerView)

        todoTitle.text = todoItem.description
        todoTitle.numberOfLines = 0
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        todoTitle.font = .boldSystemFont(ofSize: 32)
        todoTitle.textColor = .white
        view.addSubview(todoTitle)

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        todoTextField.leftView = leftView
        todoTextField.leftViewMode = .always
        todoTextField.placeholder = "Enter subtask"
        todoTextField.translatesAutoresizingMaskIntoConstraints = false
        todoTextField.backgroundColor = .white
        todoTextField.layer.borderWidth = 1
        todoTextField.layer.borderColor = UIColor.darkGray.cgColor
        todoTextField.layer.cornerRadius = 10
        todoTextField.font = .systemFont(ofSize: 15)
        view.addSubview(todoTextField)

        submitButton.setTitle("Add", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.backgroundColor = UIColor(red: 32/255, green: 171/255, blue: 211/255, alpha: 1)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(addToDoItem), for: .touchUpInside)
        view.addSubview(submitButton)

        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        todoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: todoCellReuseIdentifier)
        view.addSubview(todoTableView)

        setupConstraints()

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 300)
        ])

        NSLayoutConstraint.activate([
            todoTitle.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -20),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            todoTextField.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 20),
            todoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTextField.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor, constant: -10),
            todoTextField.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: todoTextField.topAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalTo: todoTextField.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: todoTextField.bottomAnchor, constant: 20),
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }

    @objc func addToDoItem() {
        let todo = todoTextField.text
        if let todo = todo {
            let newTodo = ToDo(description: todo, completed: false, starred: false)
            todoItem.subTodos.append(newTodo)
            todoTextField.text = ""
            todoTableView.reloadData()
        }
    }
}

extension ToDoItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem.subTodos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: todoCellReuseIdentifier, for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        cell.configure(with: todoItem.subTodos[indexPath.row], index: indexPath.row, delegate: self)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItem.subTodos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ToDoItemViewController: ToDoDelegate {
    func setCompleted(index: Int) {
        todoItem.subTodos[index].completed = !todoItem.subTodos[index].completed
        todoTableView.reloadData()
    }

    func setStarred(index: Int) {
        todoItem.subTodos[index].starred = !todoItem.subTodos[index].starred
        todoTableView.reloadData()
    }

}

