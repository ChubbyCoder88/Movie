//
//  Extensions.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
    }
}

extension String {
    func makeStringBetween(s: String, A: Int, B: Int) -> String {
        if s.count > B {
        return String(s[s.index(s.startIndex, offsetBy: A)...s.index(s.startIndex, offsetBy: B)])
        } else { return "" }
    }
    func makeStoLowerBoundRange(s: String?, lowerbound: String) -> String {
        if let range = s?.range(of: lowerbound) {
            return String(s?[..<range.lowerBound] ?? "")
        } else { return "" }
    }
    func ifLet(s: String?) -> String {
        if let s = s {
            return s
        } else { return "" }
    }
    func ifLetItS(i: Int?) -> String {
        if let i = i {
            return String(i)
        } else { return "" }
    }
    func sReFormatDate(s: String, form1: DateFormatter, form2: DateFormatter) -> String {
        if let date = form1.date(from: s) {
            return form2.string(from: date)
        } else { return "" }
    }
    func sDoubleToString(d: Double?) -> String {
        if let d = d {
            return String(d)
        } else { return "" }
    }
}

extension Bool {
    func sInData(s: String, d: [movieViewModel]) -> Bool {
        if let firstMatch = d.firstIndex(where: { $0.title == s } ) { return true  } else { return false }
    }
}

extension DateFormatter {
    func format(s: String) -> DateFormatter {
        var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = s
            return dateFormatter
    }
}

class Alert {
    class func show(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    static let myRed = UIColor(r: 212, g: 1, b: 25)               // #d40119
    static let myGray = UIColor(r: 114, g: 114, b: 114)          // #727272
    static let myBlue = UIColor(r: 0, g: 72, b: 183)              // #0048b7
    static let myBackgroundColor = UIColor(r: 250, g: 250, b: 250)// #fafafa
}
 
extension UIFont {
    static let navFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
}
extension NSAttributedString {
    static let navString = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.navFont]
}

struct Search {
    static let demo = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=f1e43ad1d15c2ad0a441b0cb0148702a&query=the+lion")!
    static var urlString = "https://api.themoviedb.org/3/search/movie?api_key="
    static var apiKey = "f1e43ad1d15c2ad0a441b0cb0148702a"
    static var imageUrl = "https://image.tmdb.org/t/p/"
}
