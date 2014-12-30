#!/bin/bash
#!/usr/bin/expect -f
#!/usr/bin/env bash
yum install -y expect wget
cd /root
wget http://172.16.92.99/share/tar/vtune_amplifier_xe_2013_update15.tar.gz
wget http://172.16.92.99/share/tar/EVAL_L_VT__VGXB-RDCJPN8X.lic
tar -zxvf vtune_amplifier_xe_2013_update15.tar.gz
expect -c "spawn sh /root/vtune_amplifier_xe_2013_update15/install.sh;
set timeout 5; expect "*Enter*"; send \"\r\n\"; 
expect "*Enter*"; send \"\r\n\";
expect "*Enter*"; send \"\r\n\";
while {1} {
expect {
"*--More--*" {send \"\r\n\"}
"*accept*" {break}
}
}
expect "*accept*"
send "accept\\r"
expect "*selection*";send "3\\r";
expect "*choice*"; send "2\\r";
send "/root/EVAL_L_VT__VGXB-RDCJPN8X.lic"
expect "*Enter*"; send \"\r\n\";
expect "*selection:*"; send "1\\r";
expect "*Enter*"; send \"\r\n\";
set timeout 25;
expect "*Enter*"; send \"\r\n\";
expect "*Enter*"; send \"\r\n\";
expect eof;"
rm -rf /root/* 
source /opt/intel/vtune_amplifier_xe_2013/amplxe-vars.sh
