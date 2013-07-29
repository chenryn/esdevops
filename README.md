esdevops
========

elasticsearch devops example for PerlChina Beijing Workshop 2013

usage
========

```
    cpanm Rex
    git clone https://github.com/chenryn/esdevops.git
    cd eesdevops
    rex init --name esdevops
    open http://localhost:8888/
```

TODO
=======

Now here are only logstash and message-passing, need PerlWeekly index.pl and Git::Search repo.

I will add Esty Kale when I can genarate abnormal timeseries data to tigger warnings ==!

ElasticSearch Indexing Speed Test
==============

Testing data:

```
$ wc -l access.log.10 
100000 access.log.10
```

## `$self->_regex->regexp()` in `filter` sub

```
$ time cat access.log.10 | ./mp-agent.pl 

real    1m22.519s
user    1m13.296s
sys     0m1.452s
```

## pre-stored `$self->_re` instead

```
$ time cat access.log.10 | ./mp-agent.pl 

real    0m44.606s
user    0m37.460s
sys     0m1.128s
```

## use `Logstash::Output::ElasticSearchHTTP` with default config:

```
$ time cat access.log.10 | java -jar logstash-1.1.13-flatjar.jar agent -f logstash-sample.conf 

real    4m30.013s
user    2m34.680s
sys     0m4.500s
```

## increase `flush_size` to 1000 (same as message-passing):

```
$ time cat access.log.10 | java -jar logstash-1.1.13-flatjar.jar agent -f logstash-sample.conf 

real    3m41.657s
user    2m27.164s
sys     0m4.420s

```
