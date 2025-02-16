//
//  UIView+addSubviews.swift
//  ManufactureMonitoring
//
//  Created by Admin on 06.01.2025.
//
import UIKit

public extension UIView {
    func addSubviews(_ views : UIView ...) {
        views.forEach {
            addSubview($0)
        }
    }
}
