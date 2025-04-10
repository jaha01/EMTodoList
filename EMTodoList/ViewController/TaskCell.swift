//
//  TaskCell.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 09.04.2025.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let checkCircle: UIImageView = {
        let checkCircle = UIImageView()
        checkCircle.tintColor = .yellow
        checkCircle.translatesAutoresizingMaskIntoConstraints = false
        return checkCircle
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 1
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        selectionStyle = .none
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Public properties

    func configure(with task: Task) {
        checkCircle.image = UIImage(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
        titleLabel.attributedText = task.isCompleted ? task.title.strikethrough() : NSAttributedString(string: task.title)
        titleLabel.textColor = task.isCompleted ? .gray : .white
        descriptionLabel.text = task.description
        dateLabel.text = task.date
    }

    // MARK: - Private properties
    
    private func setup() {
        
        contentView.addSubview(checkCircle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            checkCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            checkCircle.widthAnchor.constraint(equalToConstant: 32),
            checkCircle.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkCircle.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

    }
    
}

// MARK: - Helper

extension String {
    func strikethrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: self.count))
        return attributeString
    }
}
