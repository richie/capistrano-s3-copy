require 'capistrano/recipes/deploy/strategy/copy'
require 'fileutils'
require 'tempfile'  # Dir.tmpdir

module Capistrano
  module Deploy
    module Strategy
      class S3Copy < Copy
          # Distributes the file to the remote servers
          def distribute!
            raise "uhuihuihuhi"
#            upload(filename, remote_filename)
#            run "cd #{configuration[:releases_path]} && #{decompress(remote_filename).join(" ")} && rm #{remote_filename}"
          end
      end
    end
  end
end
