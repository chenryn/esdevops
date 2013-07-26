package esdevops::Logstash;

use Rex -base;
use Rex::Commands::Download;

desc 'Get logstash jar';
task 'get_logstash_jar', group => 'servers', sub {
   download "https://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar";
};

1;
