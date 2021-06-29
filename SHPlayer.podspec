#
# Be sure to run `pod lib lint SHPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SHPlayer'
  s.version          = '0.1.0'
  s.summary          = '基于ijkplayer的播放器,可播RMTP、网络视频、本地视频等等'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
              基于ijkplayer的播放器,可播RMTP、网络视频、本地视频等等
                       DESC

  s.homepage         = 'https://github.com/QiuYeHong90/SHPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yeqiu' => '793983383@qq.com' }
  s.source           = { :git => 'https://github.com/QiuYeHong90/SHPlayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.vendored_frameworks = "IJKMediaFramework.xcframework"
  s.source_files = 'SHPlayer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SHPlayer' => ['SHPlayer/Assets/*.png']
  # }
  s.libraries     = "c++", "z", "bz2"
  s.frameworks    = ["UIKit", "Foundation", "MediaPlayer", "CoreAudio", "AudioToolbox", "Accelerate", "QuartzCore", "OpenGLES", "AVFoundation","CoreVideo","AVKit","CoreMedia","VideoToolbox","CoreTelephony"]

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
