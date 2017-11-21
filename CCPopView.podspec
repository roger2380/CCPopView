
Pod::Spec.new do |s|

  s.name         = "CCPopView"
  s.version      = "1.0.4"
  s.summary      = "A short description of CCPopView"
  s.license      = "MIT"
  s.author       = "xbwu"
  s.platform     = :ios
  s.platform     = :ios, "6.0"
  s.homepage     = "https://github.com/roger2380/CCPopView"
  s.source       = { :git => "https://github.com/roger2380/CCPopView.git", :tag => "#{s.version}" }

  s.source_files = "CCPopView/*.{h,m}"
end
