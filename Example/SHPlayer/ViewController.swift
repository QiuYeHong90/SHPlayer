//
//  ViewController.swift
//  SHPlayer
//
//  Created by yeqiu on 06/29/2021.
//  Copyright (c) 2021 yeqiu. All rights reserved.
//

import AVKit
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
//        guard let path = Bundle.main.path(forResource: "data.txt", ofType: nil) else {
//            return
//        }
////        data.txt
//        guard let text = try? String.init(contentsOfFile: path) else {
//            return
//        }
////        #EXTM3U
//        let test = text.components(separatedBy: "#EXTM3U\n").last ?? ""
//        let list = test.components(separatedBy: "#EXTINF:-1 ")
//        var modelList:[VideoModel] = []
//        for item in list {
//            let mList = item.components(separatedBy: "\n")
//            let titles = (mList.first ?? "").components(separatedBy: " ")
//            let jj = titles.first { testItem in
//                return testItem.hasPrefix("group-title=")
//            } ?? ""
//
//            print("mList == \(mList) \(mList.count)")
//
//
//
////            let mList = mList.first.components(separatedBy: ":rtmp")
//            var itemM = VideoModel.init()
//            itemM.name = jj.components(separatedBy: "group-title=").last ?? ""
//            if mList.count >= 2 {
//                itemM.url = mList[1]
//            }
//
//
//            modelList.append(itemM)
//        }
//
//        self.dataArray = modelList
//        self.dataArray = [.init(name: "test", url: "https://d1yk6suzx1fql9.cloudfront.net/video/20230811/18bar65n2v337bvsqu097hjso9-16917495168100.mp4")]
//        self.tableView.reloadData()
    }
    @IBAction func tClick(_ sender: Any) {
//        "rtmp://58.200.131.2:1935/livetv/cctv6"
        self.playerView.stop()
//        http://203.162.235.41:16908
        let url = "https://d1yk6suzx1fql9.cloudfront.net/video/20230811/18bar65n2v337bvsqu097hjso9-16917495168100.mp4"
        self.playerView.playbackRate = 1.5
        self.playerView.isVideotoolbox = false
        self.playerView.play(url: url)
        self.playerView.prepareToPlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func btnClick(_ sender: Any) {
        
        self.playerView.stop()
//        http://203.162.235.41:16908
        let url = "https://d1yk6suzx1fql9.cloudfront.net/video/20230811/18bar65n2v337bvsqu097hjso9-16917495168100.mp4"
        self.playerView.playbackRate = 1
        
        self.playerView.isVideotoolbox = true
        self.playerView.play(url: url)
        self.playerView.prepareToPlay()
        
//        ijk_av_dict_get
//        ijk_av_strstart
        
        let jj = AVPictureInPictureController.init(playerLayer: AVPlayerLayer())
        
        jj?.stopPictureInPicture()
//        AVPictureInPictureController
        
//        AVPictureInPictureController.init(playerLayer: <#T##AVPlayerLayer#>)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension UIColor{
    /// 十六进制的必须是 6 位 前两位 r 中间两位 g 后两位 b
    public static func color(hex:String) -> UIColor? {
        print("hex \(hex)")
        //16进制字符串转换10进制
        let text = Scanner.init(string: hex)
        
        var colorValue:UInt64 = 0
        text.scanHexInt64(&colorValue)
        print("colorValue \(colorValue)")
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        // 保留前两位 向右位移4位就是2 的16 次方 （16 进制每一位为 2 的4次方 总共 4个 2的4次方 一共为 2的16次方）
        red = CGFloat((colorValue & 0xFF0000)>>16)/0xFF
        // 保留中间两位 向右位移2位就是2 的8 次方
        green = CGFloat((colorValue & 0x00FF00)>>8)/0xFF
        // 保留后两位
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
            // 0-9 从48开始
            //  A-Z 从65开始，但有初始值10，所以应该是减去55
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
        
        self.playerView.stop()
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
