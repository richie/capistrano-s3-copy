
Capistrano::Configuration.instance(false).load do
  namespace :s3_copy do
    task :store_aws_install_scipt_on_s3 do
      s3cmd_vars = []
      ["aws_access_key_id", "aws_secret_access_key"].each do |var|
        value = fetch(var.to_sym)
        raise Capistrano::Error, "Missing configuration[:#{var}] setting" if value.nil?
        s3cmd_vars << "#{var.upcase}=#{value}"
      end
      aws_environment = s3cmd_vars.join(" ")
      bucket_name = configuration[:aws_s3_copy_bucket]
      remote_install_script = "s3://#{bucket_name}/#{rails_env}/aws_install.sh"
      local_install_script = File.join(File.expand_path(configuration[:copy_dir] || Dir.tmpdir, Dir.pwd), "aws_install.sh")
      s3_push_cmd = "#{aws_environment} s3cmd --no-progress put #{local_install_script} #{remote_install_script} 2>&1"
      run_locally(s3_push_cmd)
    end
  end

  after 'update_code', 's3_copy:store_aws_install_script_on_s3'
end