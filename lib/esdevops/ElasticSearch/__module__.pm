package esdevops::ElasticSearch;

use Rex -base;
use Rex::Commands::Download;
use Rex::Commands::Gather;
use Rex::Commands::SCM;

desc "Install ElasticSearch";
task "install_es", group => 'servers', sub {
   download "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.1.deb";
   run "dpkg -i elasticsearch-0.90.1.deb";
};

desc "Configure ElasticSearch";
task "config_es", group => 'servers', sub {
   file "/etc/init.d/elasticsearch",
      content => template("files/etc/init.d/elasticsearch", memsize => sprintf "%.0fg", memory->{'total'} / 2048 );
   file "/etc/elasticsearch/elasticsearch.yml",
      content => template("files/etc/elasticsearch/elasticsearch.yml", clustername => "logstash");
   service elasticsearch => ensure => "started";
};

desc "Install Kibana3";
task "install_kibana3", group => 'servers', sub {
   set repository => 'kibana',
      url => 'https://github.com/elasticsearch/kibana.git';
   checkout 'kibana',
      path => '/usr/share/kibana3';
   config_nginx();
};

desc "Configure Nginx to serve kibana3";
task "config_nginx", group => 'servers', sub {
   run "ln -s /usr/share/kibana3/sample/nginx.conf /etc/nginx/conf.d/kibana.conf";
   service nginx => ensure => "started";
};

1;
