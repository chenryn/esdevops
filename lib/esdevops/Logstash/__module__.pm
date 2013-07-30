package esdevops::Logstash;

use Rex -base;
use Rex::Commands::Download;

desc 'Get logstash jar';
task 'get', sub {
   run "wget https://logstash.objects.dreamhost.com/release/logstash-1.1.13-flatjar.jar";
};

1;
