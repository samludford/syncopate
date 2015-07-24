Pod::Spec.new do |s|
  s.name = ‘Syncopate’
  s.version = ‘0.1’
  s.license = 'MIT'
  s.summary = 'A simple, flexible library for handling clocking and synchronisation in music apps.'
  s.homepage = 'https://github.com/samludford/syncopate'
  s.social_media_url = 'https://twitter.com/sam_ludford'
  s.authors = { ‘Sam Ludford’ => ‘sam@samludford.com’ }
  s.source = { :git => 'https://github.com/samludford/syncopate.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = ‘Framework/Syncopate/Syncopate/*.swift'

  s.requires_arc = true
end