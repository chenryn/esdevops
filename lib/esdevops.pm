package esdevops;

use Rex -base;

require logstash;
require elasticsearch;
require message_passing;

batch "all", qw/install_es install_kibana3 config_nginx get_logstash_jar get_mp/;

1;
