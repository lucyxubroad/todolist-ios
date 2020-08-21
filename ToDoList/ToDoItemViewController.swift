//
//  ToDoItemViewController.swift
//  ToDoList
//
//  Created by Lucy Xu on 8/21/20.
//  Copyright © 2020 flick. All rights reserved.
//

import UIKit

class ToDoItemViewController: UIViewController {

    private var todoItem: String!
    private let todoLabel = UILabel()

    init(todoItem: String) {
        super.init(nibName: nil, bundle: nil)
        self.todoItem = todoItem
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        todoLabel.text = todoItem
        todoLabel.translatesAutoresizingMaskIntoConstraints = false
        todoLabel.font = .systemFont(ofSize: 15)
        todoLabel.textColor = .black
        view.addSubview(todoLabel)

        NSLayoutConstraint.activate([
            todoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            todoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            todoLabel.heightAnchor.constraint(equalToConstant: 15)
        ])

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
