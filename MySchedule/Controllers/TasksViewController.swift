//
//  TasksViewController.swift
//  MySchedule
//
//  Created by Гаджи Агаханов on 21.07.2021.
//

import UIKit
import FSCalendar

class TasksViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Tasks"
        calendar.delegate = self
        calendar.dataSource = self
        //недельное отображение календаря
        calendar.scope = .week
        
        setConstrains()
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        swipeAction()
   
    }

    var calendarHeightConstraint : NSLayoutConstraint!
    
    //настройка календаря
    private var calendar: FSCalendar = {
        
    let calendar = FSCalendar()
        
    //отключение таймера
    calendar.translatesAutoresizingMaskIntoConstraints = false
    return calendar
    }()
    
    let showHideButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Open calendar", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    @objc func showHideButtonTapped() {
        
        if calendar.scope == .week {
            
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        
        } else {
            
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
            
        }
    }
    //спайп календаря
    func swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
        
    }
}

extension TasksViewController: FSCalendarDataSource, FSCalendarDelegate {
    //констреинт будет меняться в зависимости от высоты календаря
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
}

extension TasksViewController {
    
    func setConstrains() {
        //добавляем календарь во вью
        view.addSubview(calendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        //настраиваем констреинты
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        //расположение кнопки календаря
        view.addSubview(showHideButton)
        
        //настраиваем констреинты
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 100),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
