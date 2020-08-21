//
//  ViewController.swift
//  ToDoList
//
//  Created by Lucy Xu on 8/21/20.
//  Copyright © 2020 flick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let todoTableView = UITableView(frame: .zero, style: .plain)
    private let todoTextField = UITextField()
    private let todoLabel = UILabel()
    private let submitButton = UIButton()

    private var todoArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My To Do List"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

        todoLabel.text = "Use me to keep up with your all your todos!"
        todoLabel.translatesAutoresizingMaskIntoConstraints = false
        todoLabel.font = .systemFont(ofSize: 15)
        todoLabel.textColor = .black
        view.addSubview(todoLabel)

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        todoTextField.leftView = leftView
        todoTextField.leftViewMode = .always
        todoTextField.placeholder = "Enter To Do"
        todoTextField.translatesAutoresizingMaskIntoConstraints = false
        todoTextField.backgroundColor = .white
        todoTextField.layer.borderWidth = 1
        todoTextField.layer.borderColor = UIColor.black.cgColor
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
        view.addSubview(todoTableView)
        setupConstraints()

    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            todoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            todoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            todoLabel.heightAnchor.constraint(equalToConstant: 15)
        ])

        NSLayoutConstraint.activate([
            todoTextField.topAnchor.constraint(equalTo: todoLabel.bottomAnchor, constant: 20),
            todoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTextField.widthAnchor.constraint(equalToConstant: 300),
            todoTextField.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: todoTextField.topAnchor),
            submitButton.leadingAnchor.constraint(equalTo: todoTextField.trailingAnchor, constant: 10),
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
            todoArray.append(todo)
            todoTextField.text = ""
            todoTableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = todoArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoItemViewController = ToDoItemViewController(todoItem: todoArray[indexPath.row])
        navigationController?.pushViewController(todoItemViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
