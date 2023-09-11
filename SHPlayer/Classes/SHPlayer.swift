//
//  SHPlayer.swift
//  SHPlayer
//
//  Created by ray on 2021/6/29.
//

import IJKMediaFramework
import UIKit
// 日志回调方法
func ijkPlayerLogCallback(log: String) {
    // 在此处处理日志输出，例如打印到控制台或保存到文件
    print("IJKPlayer Log: \(log)")
}
public class SHPlayer: UIView {
    
    public var url:URL?
    public private(set) var newUrl: URL?
    /// 倍速播放 默认1倍速
    public var playbackRate: Float = 1
    public var isVideotoolbox: Bool = true
    
    var player:IJKFFMoviePlayerController?
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCommon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initCommon()
    }
    
    func initCommon() {
        self.toPlay()
    }
    public func stop() {
        self.player?.stop()
    }
    public func play(url:String) {
        if url.hasPrefix("http") || url.hasPrefix("rtmp") {
            self.url = URL.init(string: url)
        }else{
            self.url = URL.init(fileURLWithPath: url)
        }
        self.toPlay()
    }
    func toPlay() {
        IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
        // 设置日志级别
        IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)

        // 注册日志回调
        IJKFFMoviePlayerController.setLogReport(true)
        
//        IJKSDLGLViewProtocol
        // 注册日志回调方法
//        IJKFFMoviePlayerController.
//        IJKFFMoviePlayerController.registerLogCallback(ijkPlayerLogCallback)
        guard let options = IJKFFOptions.byDefault() else {
            return
        }
        /// 0 是软解吗 1 是硬解码
        if isVideotoolbox {
            options.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        } else {
            options.setPlayerOptionIntValue(0, forKey: "videotoolbox")
        }
        
        
        
        options.setPlayerOptionIntValue(5, forKey: "framedrop")
        
//        缓存
        let filePath = self.getCacheFile(with: self.url)
        let mapPath = self.getMapPath(with: self.url)
        
//        options.setOptionIntValue(1, forKey: "dns_cache_clear", of: kIJKFFOptionCategoryFormat)
        options.setFormatOptionValue(filePath, forKey: "cache_file_path")
//        options.setFormatOptionValue(mapPath, forKey: "cache_map_path")
        options.setFormatOptionIntValue(1, forKey: "parse_cache_map")
        options.setFormatOptionIntValue(1, forKey: "auto_save_map")
        options.setFormatOptionIntValue(0, forKey: "cache_file_close")
//        options.setFormatOptionIntValue(1, forKey: "only_read_file")
        
        
        options.setFormatOptionIntValue(1, forKey: "enable-accurate-seek")
        var strCacheUrl = "ijkio:cache:ffio:\(self.url?.absoluteString ?? "")"
//        var strCacheUrl = "cache:\(self.url?.absoluteString ?? "")"
        newUrl = URL.init(string: strCacheUrl)
        print("options == \(options)")
        
        
//        options?.setValue("ijklas", forKey: "iformat")
//        options?.setValue("ijklas", forKey: "iformat")
        guard let url = newUrl else {
            return
        }
        self.player?.view.removeFromSuperview()
        self.player = IJKFFMoviePlayerController.init(contentURL: url, with: options)
        

        self.player?.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        self.player?.view.frame = self.bounds
        self.player?.scalingMode = .aspectFit
        self.player?.shouldAutoplay = true;
        self.player?.shouldShowHudView = true
        
        player?.httpOpenDelegate = self
        
        self.autoresizesSubviews = true
        if let view = self.player?.view {
            self.backgroundColor = .red
            self.addSubview(view)
        }
        self.player?.playbackRate = playbackRate
        self.player?.play()
        print("self.playerisVideoToolboxOpen === \(String(describing: self.player?.isVideoToolboxOpen()))")
    }
    public func prepareToPlay() {
        self.player?.prepareToPlay()
    }
    
    
    func getCacheFile(with url: URL?) -> String {
        let libPath = "\(NSHomeDirectory())/Library"
        let caches = "\(libPath)/Caches/"
        let fileName = url?.pathComponents.last ?? ""
        let filePath = "\(caches)\(fileName)"
        return filePath
    }
    
    func getFileName(with url: URL?) -> String {
        let fileName = url?.pathComponents.last ?? ""
        return fileName
    }
    
    func getMapPath(with url: URL?) -> String {
        let fileName = self.getFileName(with: url)
        let filePath = self.getCacheFile(with: url)
        let libPath = "\(NSHomeDirectory())/Library"
        let caches = "\(libPath)/Caches/"
        let mapDir = "\(caches)map"
        let isExist = FileManager.default.fileExists(atPath: mapDir)
        if isExist == false {
            try? FileManager.default.createDirectory(atPath: mapDir, withIntermediateDirectories: true)
        }
        let mapPath = "\(mapDir)/\(fileName).tmp"
        print("mapPath === \(mapDir)")
        return mapPath
    }
}


extension SHPlayer: IJKMediaUrlOpenDelegate {
    public func willOpenUrl(_ urlOpenData: IJKMediaUrlOpenData!) {
        
    }
    
    
}



