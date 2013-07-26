package esdevops;

use Rex -base;
require esdevops::ElasticSearch;
require esdevops::Logstash;
require esdevops::Message::Passing; 

task "all", group => 'servers', sub {
    esdevops::ElasticSearch::install_es();
    esdevops::ElasticSearch::install_kibana3();
    esdevops::ElasticSearch::config_nginx();
    esdevops::Logstash::get_logstash_jar();
    esdevops::Message::Passing::get_mp();
};

1;
