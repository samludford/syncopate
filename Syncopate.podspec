Pod::Spec.new do |s|

    s.name         = "Syncopate"
    s.version      = "0.0.1"
    s.summary      = "A simple library for handling clocking and synchronisation in creative music apps"

  s.description  = <<-DESC
                A simple Swift library for handling clocking and synchronisation in creative music apps. Syncopate is based on ticks, which are inspired by the concept of a 'bang' in Max/MSP. Syncopate can be used in apps targeting iOS 8.0 and up.
                   DESC

    s.homepage     = "https://github.com/samludford/syncopate"
    s.license      = "MIT"
    s.author             = { "Sam Ludford" => "sam@samludford.com" }
    s.social_media_url   = "http://twitter.com/sam_ludford"


    s.platform     = :ios
    s.platform     = :ios, "8.0"

    s.source       = { :git => "https://github.com/samludford/syncopate.git", :tag => "0.0.1" }
    s.source_files  = "Framework", "Framework/**/*.{swift}"

end
