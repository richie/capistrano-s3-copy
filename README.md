# Capistrano::S3::Copy

This is a revised implementation of the ideas in Bill Kirtleys capistrano-s3 gem.

I have a requirement to push new deployments via capistrano, but also to retain the last
deployed package in S3 for the purposes of auto-scaling. 

This gem use Capistrano's own code to build the tarball package, but instead of 
deploying it to each machine, we deploy it to a configured S3 bucket (using s3cmd), then
deploy it from there to the known nodes from the capistrano script.

At some point, I aim to persist a shell script to accompany the package. This will be used
to instruct a fresh AWS instance how to locate, download and install he S3 package as if
it was deployed via capistrano.

## Installation

Add these line to your application's Gemfile:

    group :development do
      gem 'capstrano-s3-copy'
    end  

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-s3-copy

## Usage

In your deploy.rb file, we need to tell Capistrano to adopt our new strategy:

    set :deploy_via, :s3_copy

Then we need to provide AWS account details to authorize the upload/download of our 
package to S3

    set :aws_access_key_id,     ENV['AWS_ACCESS_KEY_ID']
    set :aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']

Finally, we need to indicate which bucket to store the packages in:

    set :aws_s3_copy_bucket, 'mybucket-deployments'

The package will be stored in S3 prefixed with a rails_env that was set in capistrano:

e.g.

    S3://mybucket-deployment/production/201204212007.tar.gz

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
