Pod::Spec.new do |s|

    s.name         = "Syncopate"
    s.version      = "0.0.1"
    s.summary      = "A simple library for handling clocking and synchronisation in music apps"

#  s.description  = <<-DESC
#                   A longer description of Syncopate in Markdown format.

#                   * Think: Why did you write this? What is the focus? What does it do?
#                   * CocoaPods will be using this to generate tags, and improve search results.
#                   * Try to keep it short, snappy and to the point.
#                   * Finally, don't worry about the indent, CocoaPods strips it!
#                   DESC

    s.homepage     = "https://github.com/samludford/syncopate"
    s.license      = "MIT"
    s.author             = { "Sam Ludford" => "sam@samludford.com" }
    s.social_media_url   = "http://twitter.com/sam_ludford"


    s.platform     = :ios
    s.platform     = :ios, "8.0"

    s.source       = { :git => "https://github.com/samludford/syncopate.git", :tag => "0.0.1" }
    s.source_files  = "Framework", "Framework/**/*.{swift}"

end
