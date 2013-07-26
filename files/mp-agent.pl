#!/usr/bin/perl
use Modern::Perl 2010;
use Moo;
use MooX::Options;
use Message::Passing::DSL;
use MooX::Types::MooseLike::Base qw/ Str /;
use namespace::clean -except => [qw( meta _options_data _options_config )];
with 'Message::Passing::Role::Script';
option servers => (
    is      => 'ro',
    isa     => Str,
    default => sub { '127.0.0.1:9200' },
);

sub build_chain {
    my $self = shift;
    message_chain {
        output es => (
            class                 => 'ElasticSearch',
            elasticsearch_servers => [ $self->servers ]
        );
        output pocketio => ( class => 'PocketIO', hostname => '10.2.21.100' );
        filter key => (
            class      => 'Key',
            key        => '@message',
            match_type => 'regex',
            match      => ' 404 ',
            output_to  => 'pocketio'
        );
        filter multi => ( class => 'T', +output_to => [ 'key', 'es' ] );
        filter regexp => (
            class     => 'Regexp',
            output_to => 'multi',
            regexfile => './regex.txt',
            format    => ':default',
            capture   => [
                qw( ts status remotehost url oh responsetime upstreamtime bytes )
            ],
            mutate => {
                responsetime => 'number',
                upstreamtime => 'number',
                bytes        => 'number',
                status       => 'string',
            },
        );
        filter logstash => ( class => 'ToLogstash', output_to => 'regexp' );
        input stdin     => ( class => 'STDIN',      output_to => 'logstash' );
    };
}
__PACKAGE__->start unless caller;
1;
