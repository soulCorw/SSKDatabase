
Pod::Spec.new do |s|
    s.name         = 'SSKDatabase'
    s.version      = '1.0.0'
    s.summary      = 'SSKDatabase'
    s.homepage     = 'https://github.com/soulCorw/SSKWebKit'
    s.license      = 'Apache-2.0'
    s.authors      = {'SSKWebKit iOS' => 'git@github.com:soulCorw'}
    s.platform     = :ios, '10.0'
    s.source       = {:git => 'git@github.com:soulCorw/SSKWebKit.git', :tag => s.version}



    s.source_files = 'SSKWebKit/SSKWebKit/Sources/*.swift'
    s.resource     = 'SSKWebKit/SSKWebKit/Sources/SSKWebKit.bundle'
    


    s.dependency 'RealmSwift'

    
    
    
    s.swift_version = '5.0'
end
