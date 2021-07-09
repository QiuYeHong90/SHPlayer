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
        let mut =  text.keyWords_swift(keyWord)
        
        self.textLab.attributedText = mut
    }
    
}


extension String{
    func nsRange(from range: Range<String.Index>) -> NSRange {
            let from = range.lowerBound.samePosition(in: utf16)!
            let to = range.upperBound.samePosition(in: utf16)!
            return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                           length: utf16.distance(from: from, to: to))
        }
    func keyWords_swift(_ keyWords: String, withKeyWordsColor color: UIColor = .red) -> NSMutableAttributedString? {
        
        let mutableAttributedStr = NSMutableAttributedString.init(string: self)
        if keyWords.isEmpty {
            return mutableAttributedStr
        }
        let text = NSString.init(string: self)
        
        
        var range = text.range(of: keyWords)
        if let tempR = self.range(of: keyWords) {
            let upperBound = tempR.upperBound
            print("tempR  = upperBound \(tempR.upperBound)  lowerBound \(tempR.upperBound)")
        
//            NSRange.init(location: <#T##Int#>, length: <#T##Int#>)
        }
        var searchRange = NSMakeRange(0, self.count);
        
        while range.location != NSNotFound {
            mutableAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            //改变多次搜索时searchRange的位置
            searchRange = NSMakeRange(NSMaxRange(range), self.count - NSMaxRange(range));
            range = text.range(of: keyWords, options: [], range: searchRange)
        }
        
        return mutableAttributedStr
    }
    
    func keyWords_swiftNormal(_ keyWords: String, withKeyWordsColor color: UIColor = .red) -> NSMutableAttributedString? {
        
        let mutableAttributedStr = NSMutableAttributedString.init(string: self)
        if keyWords.isEmpty {
            return mutableAttributedStr
        }
        let text = NSString.init(string: self)
        let range = text.range(of: keyWords)
        
        if let tempR = self.range(of: keyWords) {
            print("tempR  = \(tempR)")
//            NSRange.init(location: <#T##Int#>, length: <#T##Int#>)
        }
        if range.location != NSNotFound {
             mutableAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        return mutableAttributedStr
    }
}

