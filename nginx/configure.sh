#!/usr/bin/bash

./configure --prefix=/home/dyc/tools/nginx \
            --with-pcre=/home/dyc/tools/pcre/ \
            --with-zlib=/home/dyc/tools/zlib \
            --with-debug  \
            --add-module=/home/dyc/tools/ngx_devel_kit \
            --add-module=/home/dyc/tools/lua-nginx-module
