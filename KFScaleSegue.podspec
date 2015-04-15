#
# Be sure to run `pod lib lint KFScaleSegue.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KFScaleSegue"
  s.version          = "0.1.0"
  s.summary          = "Use segue to slide out menu viewcontroller in storyboard."
  s.description      = <<-DESC
                       Segue used in storyboard, scale old controller's view and show it's snapshot in new view;
					   DESC
  s.homepage         = "https://github.com/K6F/KFScaleSegue"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "K6F" => "Fan.Khiyuan@gmail.com" }
  s.source           = { :git => "https://github.com/K6F/KFScaleSegue.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  #s.resource_bundles = {
  #  'KFScaleSegue' => ['Pod/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
