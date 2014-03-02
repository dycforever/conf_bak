#! /bin/bash

#-----------------------------------------------------------------------------
#
# author sudodus alias nio-wiklund at launchpad
#
# date        editor   comment
# 2013-06-25  sudodus  linux installer from tarball of installed system
# 2013-06-27  sudodus  raring.tar.gz
# 2013-08-09  sudodus  removed lame logic for wipe as alternative to install
# 2013-09-22  sudodus  mktst selector introduced in mkusb
# 2013-09-26  sudodus  mktst selector tweaked for mkusb
# 2013-09-26  sudodus  mkusb cleaned, version 4.0
#
#-----------------------------------------------------------------------------

function mktst {

# select target drive, make command and run command

echo "***  Unmount the device if mounted  ****************************"
echo " "

ltest0=$(grep " / " /etc/mtab|cut -d ' ' -f 1)
if [ "$ltest0" == "/cow" ]
then
 ltest1=$(grep " /isodevice" /etc/mtab|cut -c 5-8)
 livedrive=$ltest1
elif [ "${ltest0/\/dev\/[^f]d}" != "$test0" ]
then
 livedrive=$(grep " / " /etc/mtab|cut -c 5-8)
else
 livedrive="not_found"
fi
#echo ltest0=$ltest0
#echo ltest1=$ltest1
#echo livedrive=$livedrive

for i in /dev/[^f]d?; do parted -ls|grep -B1 "$i"|tr '\n' '\t';echo "";done
echo Live drive: /dev$livedrive
for i in $(find /sys/devices -name "*sd?"|grep usb|sed s#.*/##)
do
 fdisk -lu /dev/$i 2>/dev/null|grep "Disk /dev"
done|sed 's/Disk/USB drive: /'|sort
echo " "

choice=1
usbonly=true
ans=
while [ "$ans" != "g" ]
do
 item=0
 cmdsav=

 if $usbonly; then ufl=usb; else ufl=d;fi
#  for j in $(for i in $(find /sys/devices -name "*sd?"|grep usb|grep -v $livedrive|sed s#.*/##)
  for j in $(for i in $(find /sys/devices -name "[^f]d?"|grep $ufl|grep -v $livedrive|sed s#.*/##)
            do
              fdisk -lu /dev/$i 2>/dev/null|grep "Disk /dev"|sed -e s/:.*// -e s/.*\ //
            done|sort)
 do
  busy=0
  for k in $(grep $j /etc/mtab|sed s#\ /.*##)
  do umount $k 2>/dev/null; if [ "$?" == "1" ];then busy=1;fi ;done
  if [ "$busy" == "1" ]
  then
   echo "#       could not unmount $j because file system on device is busy"
  else
   item=$(($item + 1))
#   echo $item , $choice
   if [ $item -eq $choice ]
   then
    /bin/echo -en "\0033[7m---> "
   else
    /bin/echo -en "     "
   fi

   tj="$(parted -ls|grep -B1 "$j"|tr '\n' ' '|sed s/Model:\ //;echo "")"
#   echo "${tj:1:7}"
   if [ "${tj:1:7}" == "Warning" ] || [ "${tj:1:5}" == "Error" ]
   then
     tj=$(fdisk -lu "$j" 2>/dev/null|grep "$j":|sed s/\,\ .*//)
   fi
   if [ "$source" != "/dev/zero" ]
   then
    targ0="$j"
#    cmd0="$item: install $source to $tj"
    cmd0="$item: install to $tj"
   else
    targ0="$j"
    cmd0="$item: wipe device $tj"
   fi
   echo $cmd0
   if [ "$item" == "$choice" ]
   then
    /bin/echo -en "\0033[0m"
    target="$targ0"
    cmdsav=$cmd0
   fi
  fi
 done
 
# select device, go or quit

 if [ $item -lt 1 ]
 then
  if $usbonly
  then
   echo "No USB target device available. Toggle USB-only?"
  else
   echo "No target device available"
   exit
  fi
 elif [ $item -gt 1 ]
 then
  echo "Select another device with (+/-) or the number of the list item."
 fi
 echo "Go ahead with (g) or quit with (q). Toggle USB-only with (u)."
 read ans
 if [ "$ans" == "+" ]
 then
  choice=$(($choice + 1))
  if [ $choice -gt $item ]
  then
    choice=$item
  fi
 elif [ "$ans" == "-" ]
 then
  choice=$(($choice - 1))
  if [ $choice -lt 1 ]
  then
    choice=1
  fi
 elif [ "$ans" == "u" ]
 then
  choice=1
  if $usbonly
  then
   usbonly=false
  else
   usbonly=true
  fi
 elif [ "$ans" == "q" ]
 then
  exit
 elif [ "$ans" '>' "0" ] && [ "$ans" '<' "$item" ] || [ "$ans" == "$item" ]
# elif [ "$ans" != "g" ] && [ $ans -gt 0 ] && [ $ans -le $item ]
 then
   choice=$ans
 fi
done

# here we go

/bin/echo -e "${cmdsav/install to/source: $source\n   target:}"
echo "Do you really want to wipe and install to this device? (y/n)"
read ans
if [ "$ans" == "y" ]
then
 if [ "$target" == "" ]
 then
  echo "$cmdsav"
 else
  swapoff "$target"* 2>/dev/null
  sync

# the command line is implemented 

  echo " "

# build target

  if [ "$1" == "wipe-all" ] || [ "$1" == "/dev/zero" ]
  then
   echo "Wiping the whole device $target ..."
  elif [ "$1" == "wipe-1" ] || [ "$1" == "wipe1" ]
  then
   echo "Wiping the first megabyte (MibiByte) of $target ... :"
  else
   echo "Installing $1 to $target ..."
   echo " "
  fi

# build beginning of command (read the source) and calculate size

  if [ "$source" == "$1" ]
  then
   if [ "${1/.iso}" != "$1" ]
   then
    size=$(wc -c "$1"|cut -d ' ' -f 1)
    readsrc="< $source"
   elif [ "${1/.img.[gx]z}" != "$1" ]
   then
    if [ "${1/.img.gz}.img.gz" == "$1" ]
    then
     size=$(gzip -l "$1"|grep "${1/.gz}"|tr -s ' ' ' '|sed s/^\ //|cut -d ' ' -f 2)
     readsrc="zcat $source |"
    else
#     size=$(xz -l "$1"|grep "${1/.xz}"|tr -s ' ' ' '|sed s/^\ //|cut -d ' ' -f 5,6| \
#            sed -e s/\ // -e s/..$//)
     si10=$(xz -l "$1"|grep "${1/.xz}"|tr -s ' ' ' '|sed s/^\ //| \
            cut -d ' ' -f 5|sed 's/\.//')
     sitr=$(((${si10}+5)/10))
     powr=$(xz -l "$1"|grep "${1/.xz}"|tr -s ' ' ' '|sed s/^\ //| \
            cut -d ' ' -f 6|sed -e s/..$//)
     size=$sitr$powr
     readsrc="xzcat $source |"
    fi
   fi
   size="-s ${size,,}"
  else
   readsrc="< $source"
   size=
  fi

# build pvpipe (if available)

  if $pvplug
  then
   pvpipe="pv $size |"
  else
   pvpipe=
  fi

#  echo "\$1=$1"
#  echo "source=$source"
#  echo "target=$target"
#  echo "bs=$bs"
#  echo "cnt=$cnt"
#  echo "pvplug=$pvplug"
#  echo "size=$size"
#  echo "pvpipe=$pvpipe"
#  echo "readsrc=$readsrc"

  cmdfile=$(mktemp)

  cmdline="$readsrc $pvpipe dd bs=$bs $cnt of=$target"

  echo "$cmdline"|tee $cmdfile
  bash $cmdfile
  echo "Syncing the device ..."
  rm $cmdfile
  sync
 fi
fi
}

# ---------------------------------------------------------------------
#
# mkusb main program
#
# author sudodus alias nio-wiklund at launchpad
#
# date        editor   comment
# 2013-09-22  sudodus  mktst selector introduced in mkusb
# 2013-09-24  sudodus  help text managed also for text screen
# 2013-09-26  sudodus  mkusb cleaned, version 4.0
# 2013-11-17  sudodus  not only check also offer installation of pv
# 2013-11-22  sudodus  mkusb version 5.0
#
# ---------------------------------------------------------------------

bs=4096
count=256
cnt=
target=
source="$1"
LC_ALL=C
LANG=C
inversvid="\0033[7m"
resetvid="\0033[0m"

# print version on demand

version=5.0

if [ "$1" == "-v" ]
then
 echo "mkusb version $version"
 exit
fi 


# usage text

if [ "$(whoami)" != "root" ] || [ "$#" != 1 ]
then
 echo "Usage:"
 if [ "$#" != 1 ]
 then
  echo "---- Make a USB install device from 'file.iso' -------"
  echo "sudo $0 file.iso"
  echo "---- Make a USB install device from 'file.img.gz' ----"
  echo "sudo $0 file.img.gz"
  echo "---- Make a USB install device from 'file.img.xz' ----"
  echo "sudo $0 file.img.xz"
  echo "---- Wipe the USB device (may take long time) --------"
  echo "sudo $0 wipe-all"
  echo "---- Wipe the first megabyte (MibiByte) --------------"
  echo "sudo $0 wipe-1"
  echo "---- Version -----------------------------------------"
  echo "$0 -v"
 else
  echo "sudo $0 $1"
 fi
 exit
fi

# check usage mode and input file extension

if [ "${1/.iso}.iso" != "$1" ] && \
     [ "${1/.img.gz}.img.gz" != "$1" ] && \
     [ "${1/.img.xz}.img.xz" != "$1" ]
then
 if [ "$1" == "wipe-all" ] || [ "$1" == "/dev/zero" ]
 then
  echo "Wipe the whole device ... :"
  source="/dev/zero"
 elif [ "$1" == "wipe-1" ] || [ "$1" == "wipe1" ]
 then
  echo "Wipe the first megabyte (MibiByte) ... :"
  source="/dev/zero"
  cnt="count=$count"
 else
  echo ":-( $1 is neither an iso file nor an img.{gz,xz} file :-("
  exit
 fi
elif [ ! -f "$source" ]
then
 echo ":-( $source is not found :-("
 exit
fi

# check pipe view and offer installation

which pv > /dev/null
if [ "$?" == "0" ]
then
 pvplug=true
else
 echo "The program 'pv' can show the progress during the installation."
 read -p "Do you want to install it? (y/N)" pvi
 if [ "$pvi" == "y" ]
 then
  echo "apt-get install pv"
  apt-get install pv
 fi
 which pv > /dev/null
 if [ "$?" == "0" ]
 then
  pvplug=true
 else
  pvplug=false
 fi
fi
#echo $pvplug

# check if updating 'the same' iso image

#if [ "$source" != "/dev/zero" ]
if [ "${1/.iso}.iso" == "$1" ]
then
 iso=$(mktemp -d)
 #echo "$iso"
 #echo "$source"
 
 echo "The iso file SHOULD BE loop mounted on a temporary file READ-ONLY:"
 sleep 1
 umount "$iso" >/dev/null 2>&1
 mount -o loop -t auto "$source" "$iso"
 string1=$(grep DISKNAME "$iso"/README.diskdefines|sed -e s/.*DISKNAME\ *//)
 echo "$string1 _found_ in iso-file"
 sleep 1
 umount "$iso"
 sync

 for i in /dev/sd?
 do
  mount -t auto "$i" "$iso"  >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
   string2=$(grep DISKNAME "$iso"/README.diskdefines 2>/dev/null|sed -e s/.*DISKNAME\ *//)
   sleep 0.5
   umount "$iso"
   sync
  else
   string2="not_$iso"
  fi
  if [ "$string2" == "$string1" ]
  then
   echo "$string2 _found_ in $i"
   target="$i"
  fi
 done
 umount "$iso" >/dev/null 2>&1
 rmdir "$iso"

 # echo "target: $target"
 # exit
fi

# update iso image

if [ "$target" != "" ]
then
 echo "Install to ${target}? (y/n)"
 read ans
 if [ "$ans" == "y" ]
 then
  for k in $(grep $target /etc/mtab|sed s#\ /.*##)
   do umount $k; if [ "$?" == "1" ];then busy=1;fi; done
  if [ "$busy" == "1" ]
  then
   echo "Could not unmount $j because file system on device is busy :-("
  else
   if $pvplug
   then
    echo "pv $source| dd of=$target bs=$bs ..."
    pv "$source"| dd of="$target" bs=$bs
    echo "syncing the drive ..."
   else
    echo "dd if=$source of=$target bs=$bs ..."
    dd if="$source" of="$target" bs=$bs
   fi
   echo "The $string1 USB device is re-cloned  :-)"
  fi
 fi 
else

# other alternatives: wipe or clone an iso, img.gz, img.xz file

 if [ "$source" == "/dev/zero" ]
 then
  echo "Do you want to wipe the USB device? (y/n)"
 elif [ "${1/.iso}.iso" == "$1" ]
 then
  echo "$string1 _not_ in USB device"
  echo "Do you want to make a new one? (y/n)"
 elif [ "${1/.img.gz}.img.gz" == "$1" ]
 then
  echo "Do you want to clone $1 to the USB device? (y/n)"
 elif [ "${1/.img.xz}.img.xz" == "$1" ]
 then
  echo "Do you want to clone $1 to the USB device? (y/n)"
 else
  echo "Bad choice -- exit"
  exit
 fi
 read ans
 if [ "$ans" == "y" ]

# write help text

  then
  hlptxt="/tmp/help-mkusb.txt"
  echo "sudo lshw -class disk #####" > "$hlptxt"
 # lshw -class disk >> "$hlptxt"                      # reset this one
  echo "lsusb|sort -k 4,4 -k 1 #####" >> "$hlptxt"
  lsusb|sort -k 4,4 -k 1 >> "$hlptxt"
  echo "sudo fdisk -lu 2>/dev/null|grep "/dev/[^f]d"|sort #####" >> "$hlptxt"
  fdisk -lu 2>/dev/null|grep "/dev/[^f]d"|sort >> "$hlptxt"
  echo "parted -ls #####" >> "$hlptxt"
  parted -ls  >> "$hlptxt"
  echo "blkid|sort #####" >> "$hlptxt"
  blkid|sort >> "$hlptxt"
  echo "df|grep "/dev/[^f]d"|sort #####" >> "$hlptxt"
  df|grep "/dev/[^f]d"|sort >> "$hlptxt"

  warnstr="***  WARNING: the device will be completely overwritten      ***"
  quitstr="***  quit with (q)                                           ***"
  /bin/echo -e "$inversvid""$warnstr"
  if [ "$TERM" == "linux" ]
  then
   echo "     Use the info in the less viewer  (less $hlptxt)"
   /bin/echo -e "$quitstr""$resetvid"
   read -sn 1 -t 10
   less "$hlptxt"
   /bin/echo -e "$inversvid""$warnstr"
   /bin/echo -e "     Use the info in the less viewer  (less $hlptxt)""$resetvid"

  else
   echo "     Use the info in the xterm window (less $hlptxt)"
   /bin/echo -e "$quitstr""$resetvid"
   xterm -geometry 120x40 -title "less $hlptxt" -e less "$hlptxt" 2>/dev/null &
  fi


# select target drive, make command and run command

  mktst "$1"
 fi
fi
