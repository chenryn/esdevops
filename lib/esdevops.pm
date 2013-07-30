package esdevops;

use Rex -base;
require esdevops::ElasticSearch;
require esdevops::Logstash;
require esdevops::Message::Passing;
require esdevops::Git::Search;

task "all", sub {
    esdevops::ElasticSearch::install_es();
    esdevops::ElasticSearch::install_kibana3();
    esdevops::ElasticSearch::config_nginx();
    esdevops::Logstash::get();
    esdevops::Message::Passing::get();
    esdevops::Git::Search::get();
};

1;
