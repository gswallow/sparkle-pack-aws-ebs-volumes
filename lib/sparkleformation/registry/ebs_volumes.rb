SfnRegistry.register(:ebs_volumes) do |options = {}|

  volume_type = options.fetch('volume_type', 'gp2')
  volume_count = options.fetch('volume_count', 0).to_i - 1
  volume_size = options.fetch('volume_size', 0)
  delete_on_termination = options.fetch('delete_on_termination', 'true')
  iops = options.fetch('iops', 0)
  root_vol_size = options.fetch('root_vol_size', '12')

  array!(
    -> {
      device_name '/dev/sda1'
      ebs do
        delete_on_termination 'true'
        volume_type 'gp2'
        volume_size root_vol_size.to_s
      end
    },
    if volume_count > 0
      (0...volume_count).map { |c| -> {
        device_name "/dev/sd#{(102 + c).chr}" # f, g, h, i...
        ebs do
          if volume_type == 'io1'
            iops (iops == 0 ? 3 * volume_size : iops).to_s
          end
          delete_on_termination delete_on_termination
          volume_type volume_type
          volume_size volume_size.to_s
        end
        }
      }
    end
  )
end
