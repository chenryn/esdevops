package elasticsearch;

use Rex -base;
use Rex::Commands::Download;
use Rex::Commands::SCM;

desc "Install ElasticSearch";
task "install_es", group => 'servers', sub {
   download "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.1.deb";
   run "dpkg -i elasticsearch-0.90.1.deb";
};

desc "Configure ElasticSearch";
task "config_es", group => 'servers', sub {
   file "/etc/elasticsearch/elasticsearch.yml",
      content => template("files/elasticsearch.yml");
};

desc "Install Kibana3";
task "install_kibana3", group => 'servers', sub {
   set repository => 'kibana',
      url => 'git@github.com:elasticsearch/kibana.git';
   checkout 'kibana',
      path => '/usr/share/kibana3';
   config_nginx();
};

desc "Configure Nginx to serve kibana3";
task "config_nginx", group => 'servers', sub {
   file "/etc/nginx/conf.d/kibana.conf",
      source => "/usr/share/kibana3/sample/nginx.conf",
      on_change => sub { service nginx => "restart"; };
   service nginx => ensure => "started";
};

1;
