//
//  String+Extension.swift
//  MeaningOut
//
//  Created by 최민경 on 6/30/24.
//

import UIKit

//extension String {
//    func htmlEscaped(font: UIFont, colorHex: String, lineSpacing: CGFloat) -> NSAttributedString {
//        let style = """
//                    <style>
//                    p.normal {
//                      line-height: \(lineSpacing);
//                      font-size: \(font.pointSize)px;
//                      font-family: \(font.familyName);
//                      color: \(colorHex);
//                    }
//                    </style>
//        """
//        let modified = String(format:"\(style)<p class=normal>%@</p>", self)
//        do {
//            guard let data = modified.data(using: .unicode) else {
//                return NSAttributedString(string: self)
//            }
//            let attributed = try NSAttributedString(data: data,
//                                                    options: [.documentType: NSAttributedString.DocumentType.html],
//                                                    documentAttributes: nil)
//            return attributed
//        } catch {
//            return NSAttributedString(string: self)
//        }
//    }
//}

    extension String {
        func htmlToAttributedString(defaultFont: UIFont, defaultColorHex: String, tagColorHex: String) -> NSAttributedString? {
            let style = """
            <style>
            body {
                font-family: \(defaultFont.familyName);
                font-size: \(defaultFont.pointSize)px;
                color: \(defaultColorHex);
            }
            .highlight {
                color: \(tagColorHex);
            }
            </style>
            """
            
            // Assuming <tag> is used to highlight text
            let modifiedString = "\(style)<body>\(self.replacingOccurrences(of: "<tag>", with: "<span class=\"highlight\">").replacingOccurrences(of: "</tag>", with: "</span>"))</body>"
            
            guard let data = modifiedString.data(using: .utf8) else { return nil }
            
            do {
                let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
                return attributedString
            } catch {
                return nil
            }
        }
    }
