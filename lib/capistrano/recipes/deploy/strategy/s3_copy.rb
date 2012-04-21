require 'capistrano/recipes/deploy/strategy/copy'

module Capistrano
  module Deploy
    module Strategy
      class S3Copy < Copy
      
        S3CMD_VARS = ["aws_access_key_id", "aws_secret_access_key"]
      
        def initialize(config={})
          super(config)          
          
          s3cmd_vars = []
          S3CMD_VARS.each do |var|
            value = configuration[var.to_sym]
            raise Capistrano::Error, "Missing configuration[:#{var}] setting" if value.nil?
            s3cmd_vars << "#{var.upcase}=#{value}"
          end       
          @aws_environment = s3cmd_vars.join(" ")                 
          
          @bucket_name = configuration[:aws_s3_copy_bucket]
          raise Capistrano::Error, "Missing configuration[:aws_s3_copy_bucket]" if @bucket_name.nil?
        end      
        
        def check!
          super.check do |d|
            d.local.command("s3cmd")          
            d.remote.command("s3cmd")
          end
        end          
      
        # Distributes the file to the remote servers          
        def distribute!
          package_path = filename
          package_name = File.basename(package_path)
          s3_package = "s3://#{bucket_name}/#{rails_env}/#{package_name}"
          system("#{aws_environment} s3cmd --no-progress put #{package_path} #{s3_package} 2>&1")
          
          if $? != 0
            raise Capistrano::Error, "shell command failed with return code #{$?}"
          end          
          
          run "#{aws_environment} s3cmd get #{bucket_name}:#{rails_env}/#{package_name} #{remote_filename} 2>&1"
          run "cd #{configuration[:releases_path]} && #{decompress(remote_filename).join(" ")} && rm #{remote_filename}"          
          logger.debug "done!"
        end
          
        def aws_environment            
          @aws_environment
        end
        
        def bucket_name
          @bucket_name
        end                  
      end
    end
  end
end
