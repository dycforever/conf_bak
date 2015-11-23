
SS_HOME=$HOME/tools/shadowsocks
#$SS_HOME/shadowsocks/local.py \
#    -d start \
#    -s hk-52.hxg.cc \
#    -p 58923 \
#    -k shenmaonline \
#    -m rc4-md5 \
#    --pid-file $SS_HOME/ss.pid \
#    --log-file $SS_HOME/ss.log

$SS_HOME/shadowsocks/local.py \
    -d start \
    -s hk-52.hxg.cc \
    -p 58923 \
    -k shenmaonline \
    -m rc4-md5 \
    -b 0.0.0.0 \
    --pid-file $SS_HOME/ss.pid \
    --log-file $SS_HOME/ss.log
