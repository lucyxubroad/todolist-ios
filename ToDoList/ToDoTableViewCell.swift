//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Lucy Xu on 8/23/20.
//  Copyright © 2020 flick. All rights reserved.
//

import UIKit

protocol ToDoDelegate: class {
    func setCompleted(index: Int)
    func setStarred(index: Int)
}

class ToDoTableViewCell: UITableViewCell {

    let setCompletedButton = UIButton()
    let setStarredButton = UIButton()
    let todoLabel = UILabel()

    var index: Int!
    weak var delegate: ToDoDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setCompletedButton.translatesAutoresizingMaskIntoConstraints = false
        setCompletedButton.addTarget(self, action: #selector(setCompleted), for: .touchUpInside)
        addSubview(setCompletedButton)

        todoLabel.translatesAutoresizingMaskIntoConstraints = false
        todoLabel.font = .systemFont(ofSize: 15)
        todoLabel.textColor = .black
        addSubview(todoLabel)

        setStarredButton.translatesAutoresizingMaskIntoConstraints = false
        setStarredButton.addTarget(self, action: #selector(setStarred), for: .touchUpInside)
        addSubview(setStarredButton)

        NSLayoutConstraint.activate([
            setCompletedButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            setCompletedButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            setCompletedButton.heightAnchor.constraint(equalToConstant: 20),
            setCompletedButton.widthAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            setStarredButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            setStarredButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            setStarredButton.heightAnchor.constraint(equalToConstant: 18),
            setStarredButton.widthAnchor.constraint(equalToConstant: 18)
        ])

        NSLayoutConstraint.activate([
            todoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            todoLabel.leadingAnchor.constraint(equalTo: setCompletedButton.trailingAnchor, constant: 10),
            todoLabel.trailingAnchor.constraint(equalTo: setStarredButton.trailingAnchor, constant: -10)
        ])

    }

    @objc func setStarred() {
        delegate?.setStarred(index: index)
    }

    @objc func setCompleted() {
        delegate?.setCompleted(index: index)
    }

    func configure(with todo: ToDo, index: Int, delegate: ToDoDelegate) {
        self.index = index
        self.delegate = delegate
        todoLabel.text = todo.description
        if todo.completed {
            setCompletedButton.setImage(UIImage(named: "success-filled"), for: .normal)
        } else {
            setCompletedButton.setImage(UIImage(named: "success-outline"), for: .normal)
        }
        if todo.starred {
            setStarredButton.setImage(UIImage(named: "star-filled"), for: .normal)
        } else {
            setStarredButton.setImage(UIImage(named: "star-outline"), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
