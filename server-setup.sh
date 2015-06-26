cat ~/.ssh/id_rsa.pub | ssh root@107.170.178.132 "cat >> ~/.ssh/authorized_keys"

add-apt-repository ppa:pitti/postgresql
apt-get update
apt-get install git libffi6 libffi-dev postgresql libpq-dev build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev nodejs

# Setup directories
mkdir -p /var/www/fantasy-celebrity-api/shared/tmp/sockets
mkdir -p /var/www/fantasy-celebrity-api/shared/tmp/pids
mkdir -p /var/www/fantasy-celebrity-api/shared/log
mkdir -p /var/www/shared
mkdir -p /etc/nginx/sites-available
chmod go-w /var/www/

# Add deployer user
adduser deployer
adduser deployer sudo
echo -en "$(cat /etc/sudoers)\ndeployer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# locally
cat ~/.ssh/id_rsa.pub | ssh deployer@107.170.178.132 "cat >> ~/.ssh/authorized_keys"

# Setup ruby version
mkdir ~/ruby && cd ~/ruby
wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
tar -xzf ruby-2.2.2.tar.gz
cd ruby-2.2.2/
./configure
make
make install
gem install bundler

# Postgres
su - deployer
sudo -u postgres psql postgres -c "CREATE USER fantasy_celebrity_api WITH PASSWORD 'celebrasy1';"
sudo -u postgres psql postgres -c "CREATE DATABASE fantasy_celebrity_api_production owner fantasy_celebrity_api;"
echo -en "export FANTASY_CELEBRITY_API_DATABASE_PASSWORD=celebrasy1\n$(cat ~/.bashrc)" > ~/.bashrc && source ~/.bashrc
echo -en "export SECRET_KEY_BASE=b55c73482c21eebb065ba3767287f8d441557fccdd541284fba875f92f1a1a02717c7065c1a9385aae6accf049f70ebbf35e978147dc7e17b390fcbf59fb10a8\n$(cat ~/.bashrc)" > ~/.bashrc && source ~/.bashrc
exit

### DEPLOY ###

# Nginx and puma
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62
echo "deb http://nginx.org/packages/ubuntu/ precise nginx" > /etc/apt/sources.list
apt-get install nginx
rm /etc/nginx/conf.d/default.conf

# locally
cap production puma:nginx_config
cap production puma:config

service nginx restart
