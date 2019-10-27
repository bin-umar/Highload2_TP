apt-get update
apt-get install nginx -y
apt-get install apache2-utils -y

wget https://github.com/prometheus/prometheus/releases/download/v2.11.2/prometheus-2.11.2.linux-amd64.tar.gz
tar xvzf prometheus-2.11.2.linux-amd64.tar.gz
useradd -rs /bin/false prometheus
cd prometheus-2.11.2.linux-amd64
cp prometheus promtool /usr/local/bin
sudo chown prometheus:prometheus /usr/local/bin/prometheus
mkdir /etc/prometheus
cp -R consoles/ console_libraries/ prometheus.yml /etc/prometheus
mkdir -p /data/prometheus
chmod -R 777 /data
chown -R prometheus:prometheus data/prometheus /etc/prometheus/*
cd ..

wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xvfz node_exporter-0.18.1.linux-amd64.tar.gz
cd node_exporter-0.18.1.linux-amd64/
sudo cp node_exporter /usr/local/bin
sudo useradd -rs /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
cd ..

cp webserver/prometheus.service /lib/systemd/system
cp webserver/prometheus.conf /etc/nginx/conf.d/
cp webserver/node_exporter.service /lib/systemd/system
cp \y webserver/prometheus.yml /etc/prometheus/
cp \y webserver/default.conf /etc/nginx/sites-enabled/

systemctl daemon-reaload
systemctl restart nginx
systemctl enable prometheus
systemctl start prometheus
systemctl enable node_exporter
systemctl start node_exporter

htpasswd -c /etc/prometheus/.credentials admin
