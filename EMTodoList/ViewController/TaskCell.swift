//
//  TaskCell.swift
//  EMTodoList
//
//  Created by Jahongir Anvarov on 09.04.2025.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // MARK: - Private properties
    
    var onCheckTapped: (() -> Void)?
    
    private let checkCircle: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
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
    
    @objc private func checkTapped() {
        onCheckTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - Public properties
    
    func configure(with task: Task) {
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        let image = UIImage(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle", withConfiguration: config)
        checkCircle.setImage(image, for: .normal)
        titleLabel.attributedText = task.isCompleted ? task.title?.strikethrough() : NSAttributedString(string: task.title ?? "")
        titleLabel.textColor = task.isCompleted ? .gray : .white
        descriptionLabel.text = task.taskDescription
        dateLabel.text = formatDateToString(task.date)
    }
    
    // MARK: - Private properties
    
    private func formatDateToString(_ date: Date?) -> String {
        if let safeDate = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            formatter.locale = .current
            formatter.timeZone = .current
            return formatter.string(from: safeDate)
        } else {
            return ""
        }
    }
    
    private func setup() {
        
        contentView.addSubview(checkCircle)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            checkCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            checkCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            checkCircle.widthAnchor.constraint(equalToConstant: 32),
            checkCircle.heightAnchor.constraint(equalToConstant: 32),
            //            checkCircle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkCircle.trailingAnchor, constant: 12),
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
