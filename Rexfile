use strict;
use warnings;

use Rex -feature => 0.40;
use Rex::Commands::Box;

set user => 'root';
set password => 'box';
set -passauth;

#
# CALL:
# rex init --name=esdevops --url=http://box.rexify.org/box/ubuntu-server-12.10-amd64.ova
desc "Initialize and start the VM: rex init --name=vmname [--url=http://...]";
task "init", sub {

   my $param = shift;
   my $url = $param->{url} || 'http://box.rexify.org/box/ubuntu-server-12.10-amd64.ova';

   box {
      my ($box) = @_;
      $box->name($param->{name});

      # where to download the base image
      $box->url($url);

      # default is nat
      #$box->network(1 => {
      #   type => "bridged",
      #   bridge => "eth0",
      #});

      # only works with network type = nat
      # if a key ssh is present, rex will use this to log into the vm
      # you need this if you run VirtualBox not on your local host.
      $box->forward_port(
         ssh    => [2222 => 22],
         nginx  => [8888 => 80],
         eshttp => [9200 => 9200],
      );

      # share a folder from the host system
      $box->share_folder("/root/sharedir" => "./files");

      # define the authentication to the box
      # if you're downloading one from box.rexify.org this is the default.
      $box->auth(
         user => "root",
         password => "box",
      );

      # if you want to provision the machine, 
      # you can define the tasks to do that
      $box->setup(qw/prepare esdevops:all/);
   };

};

#
# CALL:
# rex down --name=esdevops
desc "Stop the VM: rex down --name=vmname";
task "down", sub {
   
   my $param = shift;

   my $box = Rex::Commands::Box->new(name => $param->{name});
   $box->stop;
};


task "prepare", sub {

   update_package_db();
   install package => [
      "git-core",
      "redis-server",
      "nginx",
      "openjdk-7-jre",
   ];

};

require esdevops;

