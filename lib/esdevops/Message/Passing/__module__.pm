package esdevops::Message::Passing;

use Rex -base;
use Rex::Commands::SCM;

desc "get Message::Passing from github and installed by cpanm";
task "get_mp", sub {
   install package => "cpanminus";
   set repository => 'utils',
      url => 'https://github.com/chenryn/Message-Passing-Utils.git';
   checkout 'utils',
      path => 'mp-utils';
   run "cpanm ./$_" for glob("mp-utils/Message*");
};

1;

=pod

=head1 NAME

$::module_name - {{ SHORT DESCRIPTION }}

=head1 DESCRIPTION

{{ LONG DESCRIPTION }}

=head1 USAGE

{{ USAGE DESCRIPTION }}

 include qw/esdevops::Message::Passing/;
  
 task yourtask => sub {
    esdevops::Message::Passing::get_mp();
 };

=head1 TASKS

=over 4

=item example

This is an example Task. This task just output's the uptime of the system.

=back

=cut
