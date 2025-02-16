//
//  TabBarController.swift
//  ManufactureMonitoring
//
//  Created by Admin on 18.01.2025.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UITabBar.appearance().barTintColor = Colors.grey
        setTabs()
    }
    
    private func setTabs() {
        let detailView = DetailsView()
        let presenter = DetailsViewPresenter(view: detailView)
        detailView.presenter = presenter
        let detailsVC = DetailsViewController(detailView: detailView, presenter: presenter)
        
        let manufactoringProcessVC = TechnicalProcessViewController()
        
        let nav1 = UINavigationController(rootViewController: detailsVC)
        let nav2 = UINavigationController(rootViewController: manufactoringProcessVC)
       
        nav1.tabBarItem = UITabBarItem(title: "Детали", image: UIImage(systemName: "gearshape"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Тех. процесс", image: UIImage(systemName: "repeat"), tag: 2)
        
        
        setViewControllers([nav1, nav2], animated: false)
    }


}
