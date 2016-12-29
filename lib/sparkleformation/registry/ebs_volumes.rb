SfnRegistry.register(:ebs_volumes) do |options = {}|

  volume_count = options.fetch(:volume_count, 0).to_i
  volume_size = options.fetch(:volume_size, 0)
  provisioned_iops = options.fetch(:provisioned_iops, 300)
  delete_on_termination = options.fetch(:delete_on_termination, 'true')
  root_volume_size = options.fetch(:root_volume_size, '12')

  array!(
    -> {
      device_name '/dev/sda1'
      ebs do
        delete_on_termination 'true'
        volume_type 'gp2'
        volume_size root_volume_size
      end
    },
    *(0...volume_count).map { |c| -> {
      device_name "/dev/sd#{(102 + c).chr}" # f, g, h, i...
      ebs do
        delete_on_termination delete_on_termination
        volume_type if!(options[:io1_condition], 'io1', 'gp2')
        iops if!(options[:io1_condition], provisioned_iops, no_value!)
        volume_size volume_size
      end
      }
    }
  )
end
