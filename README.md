# sparkle-pack-aws-ebs-volumes
Provides a registry that creates EBS volume attachments for
an EC2 instance or launch configuration.

## Usage

Add the pack to your Gemfile and .sfn:

Gemfile:
```ruby
source 'https://rubygems.org'
gem 'sfn'
gem 'sparkle-pack-aws-ebs-volumes'
```

.sfn:
```ruby
Configuration.new do
  sparkle_pack [ 'sparkle-pack-aws-ebs-volumes' ] ...
end
```

### EBS Snapshots
In a SparkleFormation resource:
```ruby
block_device_mappings registry!(:ebs_volumes, options)
```

The `ebs_volumes` registry will return a list of block device mappings.

#### Options

The registry takes an options hash:

| Option | Default | Explanation |
|--------|---------|-------------|
| volume_type | 'gp2' | 'gp2', 'io1', 'st1', 'sc1', or 'standard' |
| volume_count | 0 | Number of identical EBS volumes to create, for RAID |
| volume_size | none | Size of each volume created |
| iops | 3 * volume_size | Number of provisioned IOPS to request, per volume |
| root_vol_size | 12 | Size of the root EBS volume (/dev/sda1) to attach to an instance |
| delete_on_termination | 'true' | Delete EBS volumes when the attached instance is terminated | 

The root volume is always 'gp2' type, and always gets deleted on termination.
