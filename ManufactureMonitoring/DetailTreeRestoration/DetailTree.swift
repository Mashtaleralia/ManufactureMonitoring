//
//  DetailTreeScript.swift
//  ManufactureMonitoring
//
//  Created by Admin on 20.01.2025.
//

import Foundation

// Класс для узла дерева (детали)
class DetailNode {
    var id: Int
    var name: String
    var dur: String
    var party: String
    var level: Int  // Уровень узла в дереве
    var children: [DetailNode]
    
    init(id: Int, name: String, dur: String, party: String, level: Int) {
        self.id = id
        self.name = name
        self.dur = dur
        self.party = party
        self.level = level
        self.children = []
    }
    
    // Добавить дочерний узел
    func addChild(_ child: DetailNode) {
        children.append(child)
    }
}

// Класс для дерева деталей
class DetailTree {
    var nodes: [Int: DetailNode] = [:]  // Словарь для хранения всех узлов по их id
    var root: DetailNode?  // Корневой узел
    
    // Добавить деталь в дерево
    func addDetail(id: Int, name: String, dur: String, party: String, parentId: Int) {
        let parentLevel = nodes[parentId]?.level ?? -1  // Уровень родителя или -1 для корня
        let node = DetailNode(id: id, name: name, dur: dur, party: party, level: parentLevel + 1)
        nodes[id] = node
        
        if parentId == -1 {
            root = node  // Это корень дерева
        } else {
            if let parentNode = nodes[parentId] {
                parentNode.addChild(node)  // Добавляем в список детей родителя
            }
        }
    }
    
    // Построение дерева из файла
    func buildTree(fromFile filePath: String) {
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
            let lines = fileContents.split(separator: "\r\n")
            
            // Пропускаем заголовок (первая строка)
            for line in lines.dropFirst() {
                let parts = line.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                
                // Извлекаем данные из строки
                if parts.count >= 9 {
                    if let id = Int(parts[1]), let parentId = Int(parts[4]) {
                        let name = parts[0]
                        let dur = parts[5]
                        let party = parts[8]
                        
                        // Добавляем деталь в дерево
                        addDetail(id: id, name: name, dur: dur, party: party, parentId: parentId)
                    }
                }
            }
        } catch {
            print("Ошибка при чтении файла: \(error)")
        }
    }
    
    // Вывод дерева
    func printTree(fromNode node: DetailNode?, level: Int = 0) {
        guard let node = node else { return }
        
        print(String(repeating: " ", count: level) + "ID: \(node.id), Name: \(node.name), Dur: \(node.dur), Party: \(node.party), Level: \(node.level)")
        for child in node.children {
            printTree(fromNode: child, level: level + 2)
        }
    }
    
    // Расчет глубины дерева
    func calculateDepth(fromNode node: DetailNode?) -> Int {
        guard let node = node else { return 0 }
        
        if node.children.isEmpty {
            return 1  // Листовой узел имеет глубину 1
        }
        
        // Рекурсивно вычисляем глубину всех дочерних узлов и берем максимум
        let childDepths = node.children.map { calculateDepth(fromNode: $0) }
        return 1 + (childDepths.max() ?? 0)
    }
}

//// Пример использования:
//let tree = DetailTree()
//
//// Указываем путь к файлу
//let filePath = "details.txt"
//
//// Строим дерево из файла
//tree.buildTree(fromFile: filePath)
//
//// Выводим дерево на экран
//if let root = tree.root {
//    tree.printTree(fromNode: root)
//    
//    // Вычисляем глубину дерева
//    let depth = tree.calculateDepth(fromNode: root)
//    print("Глубина дерева: \(depth)")
//}


//// Пример использования:
//let tree = DetailTree()
//
//// Указываем путь к файлу
//let filePath = "copy_nasosCMPX@0002.txt"
//
//// Строим дерево из файла
//tree.buildTree(fromFile: filePath)
//
//// Выводим дерево на экран
//if let root = tree.root {
//    tree.printTree(fromNode: root)
//}
