//
//  TechnicalProcessViewController.swift
//  ManufactureMonitoring
//
//  Created by Admin on 18.01.2025.
//

import UIKit
import GanttisTouch

class TechnicalProcessViewController: UIViewController {
    
    private let ganttChart = GanttChart()
    
    private let detailTree = DetailTree()
    
    //private var treeArray: [DetailNode] = []
    
    private var items: [GanttChartItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        ganttChart.frame = view.bounds
        view.addSubview(ganttChart)
        setUpChart()
        // Пример использования:
        //let tree = DetailTree()
        
        // Указываем путь к файлу
        let filePath = "/Users/admin/Desktop/aboba/ManufactureMonitoring/ManufactureMonitoring/DetailTreeRestoration/copy_nasosCMPX@0002.txt"
        
        // Строим дерево из файла
        detailTree.buildTree(fromFile: filePath)
        //print(tree.nodes)
        // Выводим дерево на экран
        if let root = detailTree.root {
            //tree.printTree(fromNode: root, level:2)
        
            // Вычисляем глубину дерева
            let depth = detailTree.calculateDepth(fromNode: root)
            print("Глубина дерева: \(depth)")
        }
        
        var treeArray = detailTree.nodes.map {$0.value}

        var uniqueItems: [DetailNode] = []
        var seenLevels: Set<Int> = Set()

        for item in treeArray {
            if !seenLevels.contains(item.level) {
                uniqueItems.append(item)
                seenLevels.insert(item.level)
            }
        }


        uniqueItems = uniqueItems.sorted(by: {$0.level < $1.level})
        //uniqueItems = Array(uniqueItems.prefix(uniqueItems.count))
        //self.treeArray = treeArray
        
        var items = uniqueItems
                .compactMap
        { item in
            let rand = Int.random(in: 2...3)
            return GanttChartItem(label: item.name, row: item.level, start: Time(year: 2019, month: 03, day: 15 + item.level, hour: 0), finish: Time(year: 2019, month: 03, day: 15 + rand + item.level, hour: 0)) }

        self.items = items
    }
    
    private func makeTheme() {
       
    }
    
    private func setUpChart() {
        let item1 = GanttChartItem(
        label: "Item 1", row: 0,
        start: Time(year: 2019, month: 03, day: 15, hour: 0),
        finish: Time(year: 2019, month: 03, day: 18, hour: 24))
        
        let item2 = GanttChartItem(
        label: "Item 2", row: 1,
        start: Time(year: 2019, month: 03, day: 18, hour: 0),
        finish: Time(year: 2019, month: 03, day: 20, hour: 24))
//        
//        let items = [item1, item2]
//        
        
        let itemManager = GanttChartItemManager(collectionProvider: self)
        let headerController = GanttChartHeaderController()
        let contentController = GanttChartContentController(
            itemManager: itemManager)
        contentController.desiredScrollableRowCount = 10
        contentController.scrollableTimeline = TimeRange(
        from: item1.start, to: item2.finish.adding(weeks: 2))
        let controller = GanttChartController(
        headerController: headerController,
        contentController: contentController)
        ganttChart.controller = controller
        
        var style = GanttChartContentBaseStyle(.standard)
        style.backgroundColor = .white
        style.barFillColor = Color(UIColor(red: 137/255, green: 176/225, blue: 174/255, alpha: 1))
        
        //UIColor(red: 137/255, green: 176/225, blue: 174/255, alpha: 1)
        var headerStyle = GanttChartHeaderBaseStyle(.standard)
        headerStyle.backgroundColor = Color(Colors.sand)
        headerStyle.borderLineWidth = 6.0
        
        //Color(red: 255/255, green: 214/225, blue: 186/255, alpha: 1)
        contentController.setStyleForTheme("My", to: style)
        headerController.setStyleForTheme("My", to: headerStyle)
        controller.theme = .custom(name: "My")
        
    }

}

extension TechnicalProcessViewController: GanttChartCollectionProvider {
    
    var totalRowCount: Int {
        if let root = detailTree.root {
            // Вычисляем глубину дерева
            let depth = detailTree.calculateDepth(fromNode: root)
            return depth
        }
        return 0
    }
    
    var preferredTimeline: GanttisTouch.TimeRange {
        return TimeRange(from: Time(year: 2019, month: 03, day: 15, hour: 0), to: Time(year: 2019, month: 04, day: 20, hour: 24))
    }
    
    func filteredItems(range: GanttisTouch.RowRange, timeline: GanttisTouch.TimeRange) -> [GanttisTouch.GanttChartItem] {
        
//        var items = treeArray
//                .compactMap
//        { GanttChartItem(label: $0.name, row: $0.level, start: Time(year: 2019, month: 03, day: 18 + $0.level, hour: 0), finish: Time(year: 2019, month: 03, day: 20 + $0.level, hour: 0)) }
//        
//        items.forEach { item in
//            let rand = Int.random(in: 15...31)
//            let randLongev = Int.random(in: 1...2)
//            item.start = Time(year: 2019, month: 03, day: rand)
//            item.finish = Time(year: 2019, month: 03, day: rand + randLongev)
//        }
//        items[0].start = Time(year: 2019, month: 03, day: 16)
//        items[0].finish = Time(year: 2019, month: 03, day: 17)
//        
//        
//        items[25].start = Time(year: 2019, month: 03, day: 16)
//        items[25].finish = Time(year: 2019, month: 03, day: 18)
        return items
    }
    
    func filteredDependencies(range: GanttisTouch.RowRange, timeline: GanttisTouch.TimeRange) -> [GanttisTouch.GanttChartDependency] {
        var dependencies = [GanttChartDependency]()
        for i in 1..<items.count {
            let dependency = GanttChartDependency(from: items[i-1], to: items[i], style: GanttChartDependencyStyle(lineColor: Color(Colors.grey)))
            //dependency.style.lineColor = Color(Colors.grey)
            
            dependencies.append(dependency)
        }
        
        return dependencies
    }
    
    
}
