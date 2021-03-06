//
//  ViewController.swift
//  SHPlayer
//
//  Created by yeqiu on 06/29/2021.
//  Copyright (c) 2021 yeqiu. All rights reserved.
//

import SHPlayer
import UIKit

struct VideoModel {
    var name:String = ""
    var url:String?
    
    
}

class ViewController: UIViewController {
    var dataArray:[VideoModel] = []
    
    @IBOutlet weak var videoView_h: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerView: SHPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.videoView_h.constant = self.view.bounds.size.width
        self.view.layoutIfNeeded()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadData()
        
    }
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "data.txt", ofType: nil) else {
            return
        }
//        data.txt
        guard let text = try? String.init(contentsOfFile: path) else {
            return
        }
        let list = text.components(separatedBy: "\n")
        var modelList:[VideoModel] = []
        for item in list {
            let mList = item.components(separatedBy: ":rtmp")
            var itemM = VideoModel.init()
            itemM.name = mList.first ?? ""
            if let url = mList.last {
                itemM.url = "rtmp\(url)"
            }
           
            modelList.append(itemM)
        }
        
        self.dataArray = modelList
        self.tableView.reloadData()
    }
    @IBAction func tClick(_ sender: Any) {
//        "rtmp://58.200.131.2:1935/livetv/cctv6"
        
//        http://203.162.235.41:16908
        let url = "rtmp://media3.scctv.net/live/scctv_800"
        self.playerView.play(url: url)
        self.playerView.prepareToPlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func btnClick(_ sender: Any) {
        
        let m = 0xf & 0x9
        print("m == \(m)")
//        let color = UIColor.hex(text: "00FF00")
        let color = UIColor.color(hex: "00FF00")
        self.view.backgroundColor = color
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension UIColor{
    /// ???????????????????????? 6 ??? ????????? r ???????????? g ????????? b
    public static func color(hex:String) -> UIColor? {
        print("hex \(hex)")
        //16?????????????????????10??????
        let text = Scanner.init(string: hex)
        
        var colorValue:UInt64 = 0
        text.scanHexInt64(&colorValue)
        print("colorValue \(colorValue)")
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        // ??????????????? ????????????4?????????2 ???16 ?????? ???16 ?????????????????? 2 ???4?????? ?????? 4??? 2???4?????? ????????? 2???16?????????
        red = CGFloat((colorValue & 0xFF0000)>>16)/0xFF
        // ?????????????????? ????????????2?????????2 ???8 ??????
        green = CGFloat((colorValue & 0x00FF00)>>8)/0xFF
        // ???????????????
        blue = CGFloat((colorValue & 0x0000FF))/0xFF
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
}


extension UIColor{
    static func hex(text:String)->UIColor {
        var r:String = ""
        var g:String = ""
        var b:String = ""
        for (index,item) in text.enumerated() {
            if index < 2 {
                r.append(item)
            }
            if index < 4,index >= 2 {
                g.append(item)
            }
            if index < 6,index >= 4 {
                b.append(item)
            }
        }
        
        let red = CGFloat(UIColor.hextoInt(text: r))/0xFF
        let green = CGFloat(UIColor.hextoInt(text: g))/255.0
        let blue = CGFloat(UIColor.hextoInt(text: b))/255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func hextoInt(text:String) -> Int {
        var sum:Int = 0
        var index = text.count - 1
        for item in text.utf8 {
            // 0-9 ???48??????
            //  A-Z ???65????????????????????????10????????????????????????55
            var myValue = 0
            let count = Int(item)
            if count >= 65 {
                myValue = count - 65 + 10
            }else{
                myValue = count - 48
            }
            let test = 1<<(index * 4)
            print("1<<(index) \(test)")
            sum = sum + test * myValue
            print("=== \(myValue)  sum \(sum)")
            
            index = index - 1
        }
        return sum
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "UITableViewCell")
        }
        let model = self.dataArray[indexPath.row]
        cell?.textLabel?.text = model.name
        if let url = self.playerView.url?.absoluteString,url.isEmpty == false,url == model.url {
            cell?.contentView.backgroundColor = UIColor.red
        }else{
            cell?.contentView.backgroundColor = UIColor.white
        }
        return cell!
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row]
        
        
        guard let url = model.url else {
            return
        }
        self.playerView.play(url: url)
        self.playerView.prepareToPlay()
        self.tableView.reloadData()
        
        
        if let url = self.playerView.url?.absoluteString,url.isEmpty == false,url == model.url {
            
        }else{
           
        }
        
        print("-=-= \(self.playerView.url?.absoluteString) == \(model.url)  \(model.url == self.playerView.url?.absoluteString)")
    }
}
