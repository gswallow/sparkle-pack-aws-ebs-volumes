Gem::Specification.new do |s|
  s.name = 'sparkle-pack-aws-ebs-volumes'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.summary = 'AWS EBS Volumes SparklePack'
  s.description = 'SparklePack to generate EBS volume attachments'
  s.authors = ['Greg Swallow']
  s.email = 'gswallow@indigobio.com'
  s.homepage = 'https://github.com/gswallow/sparkle-pack-aws-ebs-volumes'
  s.files = Dir[ 'lib/sparkleformation/registry/*' ] + %w(sparkle-pack-aws-ebs-volumes.gemspec lib/sparkle-pack-aws-ebs-volumes.rb)
  s.add_runtime_dependency 'aws-sdk-core', '~> 2'
end
