//
//  ScheduleViewController.swift
//  MySchedule
//
//  Created by Гаджи Агаханов on 21.07.2021.
//

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Schedule"
        
        calendar.delegate = self
        calendar.dataSource = self
        //недельное отображение календаря
        calendar.scope = .week
        
        setConstrains()
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpOutside)
   
    }
    
    @objc func showHideButtonTapped() {
        
        if calendar.scope == .week {
            
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        
        } else {
            
            
            
        }
    }

}

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate {
    //констреинт будет меняться в зависимости от высоты календаря
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
}

extension ScheduleViewController {
    
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
