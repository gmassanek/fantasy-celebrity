add-apt-repository ppa:pitti/postgresql
apt-get update
apt-get install git libffi6 libffi-dev postgresql libpq-dev ngnix build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs

# Setup directories
mkdir /var/www
chmod -R 777 /var/www/

# Add deployer user
adduser deployer
adduser deployer sudo

# Setup ruby version
mkdir ~/ruby && cd ~/ruby
wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
tar -xzf ruby-2.2.2.tar.gz
cd ruby-2.2.2/
./configure
make
make install
gem install bundler

# Nginx and passenger
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update
sudo apt-get install nginx-extras passenger
rm /usr/bin/ruby
ln -s /usr/local/bin/ruby /usr/bin/ruby

vim /etc/nginx/nginx.conf
# Uncomment the following two lines
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /usr/local/bin/ruby;
rm /etc/nginx/sites-enabled/default
echo -en "server {\n listen 80 default_server;\n passenger_enabled on; \n passenger_app_env production; \n root /var/www/fantasy-celebrity-api/current/public;\n}\n" > /etc/nginx/sites-available/celebrasy-production
sudo ln -s /etc/nginx/sites-available/celebrasy-production /etc/nginx/sites-enabled/celebrasy-production
sudo nginx -s reload

# Postgres
su - deployer
sudo -u postgres psql postgres -c "CREATE USER fantasy_celebrity_api WITH PASSWORD 'celebrasy1';"
sudo -u postgres psql postgres -c "CREATE DATABASE fantasy_celebrity_api_production owner fantasy_celebrity_api;"

echo -en "export FANTASY_CELEBRITY_API_DATABASE_PASSWORD=celebrasy1\n$(cat ~/.bashrc)" > ~/.bashrc && source ~/.bashrc
echo -en "export SECRET_KEY_BASE=b55c73482c21eebb065ba3767287f8d441557fccdd541284fba875f92f1a1a02717c7065c1a9385aae6accf049f70ebbf35e978147dc7e17b390fcbf59fb10a8\n$(cat ~/.bashrc)" > ~/.bashrc && source ~/.bashrc


