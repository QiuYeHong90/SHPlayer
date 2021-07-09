//
//  ViewController.swift
//  AppShareDemo
//
//  Created by ray on 2021/7/6.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func textClick(_ sender: Any) {
        
        let text = "我是老李，老李今天不在家，你找老李有什么事情么李老，李师傅老了"
        let keyWord:String = "老李"
        
//        let mut =  text.normalkeyWords(keyWord, withKeyWordsColor:  UIColor.red)
        let mut = text.getMoreKeyWordsAttributedString(members: (keywrod: keyWord, color: UIColor.red),(keywrod: "今天", color: UIColor.blue))
        
        self.textLab.attributedText = mut
    }
    
}


extension String{
    func range(from nsRange: NSRange) -> Range<String.Index>? {
            guard
                let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
                let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
                let from = String.Index(from16, within: self),
                let to = String.Index(to16, within: self)
                else { return nil }
            return from ..< to
        }
    func nsRange(from range: Range<String.Index>) -> NSRange {
            let from = range.lowerBound.samePosition(in: utf16)!
            let to = range.upperBound.samePosition(in: utf16)!
            return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                           length: utf16.distance(from: from, to: to))
        }
    
    /// 遍历字符所有的关键字加颜色
    /// - Parameters:
    ///   - keyWords: 关键字
    ///   - color: 颜色
    /// - Returns: 富文本
    func keyWords_swift(_ keyWords: String, withKeyWordsColor color: UIColor = .red) -> NSMutableAttributedString? {
        
        let mutableAttributedStr = NSMutableAttributedString.init(string: self)
        if keyWords.isEmpty {
            return mutableAttributedStr
        }
        let text = NSString.init(string: self)
        var range = text.range(of: keyWords)
        var searchRange = NSMakeRange(0, self.count);
        
        while range.location != NSNotFound {
            mutableAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            //改变多次搜索时searchRange的位置
            searchRange = NSMakeRange(NSMaxRange(range), self.count - NSMaxRange(range));
            range = text.range(of: keyWords, options: [], range: searchRange)
        }
        
        return mutableAttributedStr
    }
    
    
    /// 关键字
    /// - Parameter members: 关键字
    /// - Returns: 富文本
    func getMoreKeyWordsAttributedString(members: (keywrod:String,color:UIColor)...) ->NSMutableAttributedString {
        let mutableAttributedStr = NSMutableAttributedString.init(string: self)
        if members.isEmpty {
            return mutableAttributedStr
        }
        for i in members {
            let keywrod = i.keywrod
            let color = i.color
            if keywrod.isEmpty {
                continue
            }
            
            let text = NSString.init(string: self)
            var range = text.range(of: keywrod)
            var searchRange = NSMakeRange(0, self.count);
            while range.location != NSNotFound {
                mutableAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                //改变多次搜索时searchRange的位置
                searchRange = NSMakeRange(NSMaxRange(range), self.count - NSMaxRange(range));
                range = text.range(of: keywrod, options: [], range: searchRange)
            }
            
        }
        
        return mutableAttributedStr
    }
    /// 首个关键字加颜色
    /// - Parameters:
    ///   - keyWords: 关键字
    ///   - color: 颜色
    /// - Returns: 富文本
    func keyWords_swiftFirst(_ keyWords: String, withKeyWordsColor color: UIColor = .red) -> NSMutableAttributedString? {
        
        let mutableAttributedStr = NSMutableAttributedString.init(string: self)
        if keyWords.isEmpty {
            return mutableAttributedStr
        }
        let text = NSString.init(string: self)
        let range = text.range(of: keyWords)
    
        if range.location != NSNotFound {
             mutableAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        return mutableAttributedStr
    }
}

