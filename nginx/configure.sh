#!/usr/bin/bash

./configure --prefix=/home/dyc/tools/nginx \
            --with-pcre=/home/dyc/tools/pcre/ \
            --with-zlib=/home/dyc/tools/zlib \
            --with-debug  \
            --add-module=/home/dyc/tools/ngx_devel_kit \
            --add-module=/home/dyc/tools/lua-nginx-module \
            --add-module=/home/dyc/packages/nginx-1.4.7/src/http/modules/first_filter

