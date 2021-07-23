//
//  ViewController.swift
//  MySchedule
//
//  Created by Гаджи Агаханов on 21.07.2021.
//

import UIKit

class MainTapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //загружаем вью контроллеры
        setupTapBar()
        
    }
    
    func setupTapBar() {
        
        let scheduleViewController = createNavController(vc: ScheduleViewController(), itemName: "Schedule", itemImage: "calendar.badge.clock")
        
        let tasksViewController = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        
        let contactsViewController = createNavController(vc: ContactsViewController(), itemName: "Contacts", itemImage: "rectangle.stack.person.crop")
        
        viewControllers = [scheduleViewController, tasksViewController, contactsViewController]
        
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        //смещаем картинку чуть ниже
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        //смещаем название чуть ниже
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navCotroller = UINavigationController(rootViewController: vc)
        
        navCotroller.tabBarItem = item
        
        return navCotroller
    }

}

