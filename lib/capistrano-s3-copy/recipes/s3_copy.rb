Capistrano::Configuration.instance(false).load do

  namespace :s3_copy do

    desc "Internal hook that updates the aws_install.sh script to latest if the deploy completed"
    task :store_aws_install_script_on_success do
      cmd = fetch(:s3_copy_aws_install_cmd)
      if cmd
        run_locally(cmd)
      end
    end
  end

  after 'deploy', 's3_copy:store_aws_install_script_on_success'
end