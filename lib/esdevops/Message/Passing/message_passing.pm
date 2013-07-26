package message_passing;

use Rex -base;
use Rex::Commands::SCM;

desc "get Message::Passing from github and installed by cpanm";
task "get_mp", group => 'servers', sub {
   install package => "cpanminus";
   set repository => 'utils',
      url => 'git@github.com:chenryn/Message-Passing-Utils.git';
   checkout 'utils',
      path => 'mp-utils';
   run "cpanm ./$_" for glob("mp-utils/Message*");
};

1;
