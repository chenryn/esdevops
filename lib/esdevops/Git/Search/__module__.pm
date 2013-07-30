package esdevops::Git::Search;

use Rex -base;
use Rex::Commands::SCM;

desc 'Get Git::Search repo';
task get => sub {
   set repository => 'git-search',
      url => 'https://github.com/mateu/Git-Search.git';
   checkout 'git-search',
      path => '/usr/share/gitsearch';
};

desc 'Configure Git::Search';
task config_psgi => sub {
   run "cpanm --installdeps /usr/share/gitsearch";
   file "/usr/share/gitsearch/git-search-local.conf",
      content => template('files/git-search.conf',
         gitdir => '/usr/share/gitsearch',
         subdir => 'lib');
   run "perl -I/usr/share/gitsearch/lib /usr/share/gitsearch/bin/insert_docs.pl";
   run "plackup --path /search -I/usr/share/gitsearch/lib /usr/share/gitsearch/app.psgi"
};

desc 'Configure Nginx to proxy_pass';
task config_nginx => sub {
   file '/etc/nginx/conf.d/gitsearch.conf',
      source => 'files/ngx_gitsearch.conf';
   service nginx => 'restart';
};

1;
