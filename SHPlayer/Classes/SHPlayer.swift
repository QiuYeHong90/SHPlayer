//
//  SHPlayer.swift
//  SHPlayer
//
//  Created by ray on 2021/6/29.
//

import IJKMediaFramework
import UIKit

public class SHPlayer: UIView {
    public var url:URL?
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
        
        guard let options = IJKFFOptions.byDefault() else {
            return
        }
        /// 0 是软解吗 1 是硬解码
        options.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        options.setPlayerOptionIntValue(5, forKey: "framedrop")
        
//        options?.setValue("ijklas", forKey: "iformat")
//        options?.setValue("ijklas", forKey: "iformat")
        guard let url = self.url else {
            return
        }
        self.player?.view.removeFromSuperview()
        self.player = IJKFFMoviePlayerController.init(contentURL: url, with: options)
        self.player?.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        self.player?.view.frame = self.bounds
        self.player?.scalingMode = .aspectFit
        self.player?.shouldAutoplay = true;
        self.autoresizesSubviews = true
        if let view = self.player?.view {
            self.backgroundColor = .red
            self.addSubview(view)
        }
        
    }
    public func prepareToPlay() {
        self.player?.prepareToPlay()
    }
}
