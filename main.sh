apt-get update &&
apt-get install git -y &&

cd ../home &&
git clone https://github.com/bin-umar/Highload2_TP.git webserver &&
cd webserver &&
sh ./webserver.sh &&
cd .. &&
sh webserver/commands.sh
