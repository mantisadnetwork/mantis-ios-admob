Pod::Spec.new do |s|
  s.name = "Mantis-Ad-Network-AdMob"
  s.version = "1.0.0"
  s.summary = "Monetize your mobile applications by showing advertisements from the MANTIS Ad Network."
  
  s.description = "The Google Mobile Ads SDK provides the ability to include third-party ad networks in its mediation layer, allowing you to diversiry your ad portfolio. Including this pod will give you the ability to reference our integration through the AdMob interface."

  s.homepage = "http://www.mantisadnetwork.com"
  s.license = 'MIT'
  s.author = { "MANTIS Ad Network" => "contact@mantisadnetwork.com" }
  s.platform = :ios, '5.0'
  s.source = { :git => "https://github.com/mantisadnetwork/mantis-ios-admob.git", :tag => s.version.to_s }

  s.source_files = "src"
  s.dependency "Google-Mobile-Ads-SDK", "~> 6.10"
  s.requires_arc = true
end