apt-get update
curl -sL https://deb.nodesource.com/setup_11.x | bash
apt-get install -y nodejs
npm i
npm i -g pm2
pm2 start app.js
