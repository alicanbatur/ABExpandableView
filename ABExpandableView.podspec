#
# Be sure to run `pod lib lint ABExpandableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABExpandableView'
  s.version          = '1.0.0'
  s.summary          = 'Expandable, collapsible, filterable and single/multi selectable table view.'

  s.description      = <<-DESC
    This pod lets you to list data you want with sections which have ability to expand and collapse. You can also filter rows using searchbar text input. All rows are also selectible.
    When you complete your data selection, you will have selected ids with the delegation. All these process will let you do your operations with default animations.
                       DESC

  s.homepage         = 'https://github.com/alicanbatur/ABExpandableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alicanbatur' => 'alicanbatur@gmail.com' }
  s.source           = { :git => 'https://github.com/alicanbatur/ABExpandableView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alicanbatur'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ABExpandableView/Classes/**/*.{c,h,hh,m,mm,swift}'

end
