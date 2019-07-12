workspace 'Seasoning-E-Commerce'
project 'Seasoning-E-Commerce.xcodeproj'
project 'FirebaseConnector/FirebaseConnector.xcodeproj'

platform :ios, '12.0'
inhibit_all_warnings!

target 'Seasoning-E-Commerce' do
  
  project 'Seasoning-E-Commerce.xcodeproj'

  pod 'RxCocoa', '~>5'
  pod 'RxSwift', '~>5'
  pod 'SnapKit', '~>5'

  target 'Seasoning-E-CommerceTests' do
    inherit! :search_paths
  end

end

target 'FirebaseConnector' do
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  project 'FirebaseConnector/FirebaseConnector.xcodeproj'
  target 'FirebaseConnectorTests' do
    inherit! :search_paths
  end
end
