//
//  TasksTableViewCell.swift
//  MySchedule
//
//  Created by Гаджи Агаханов on 30.07.2021.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let taskName = UILabel(text: "Программирование", font: .avenirNextDemiBold20())
    
    let taskDescription = UILabel(text: "Научиться писать extension и правильно их применять", font: .avenirNext14())
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyTuskButtonProtocol?
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //отмена выделения ячейки при нажатии
        self.selectionStyle = .none
        taskDescription.numberOfLines = 2
        setConstrains()
        
        readyButton.addTarget(self, action: #selector(readyButtonTupped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func readyButtonTupped() {
        guard let index = index else { return }
        cellTaskDelegate?.readyButtonPressed(indexPath: index)
        
    }
    

    func setConstrains() {
        //contentView добавляем, чтобы кнопка была кликабельна и не уходила в нижние слои.
        self.contentView.addSubview(readyButton)
        
        NSLayoutConstraint.activate([
        
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(taskName)
        
        NSLayoutConstraint.activate([
        
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(taskDescription)
        
        NSLayoutConstraint.activate([
        
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
    }
    
}

