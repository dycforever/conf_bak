set auto-load safe-path /

define lsof
  shell rm -f pidfile
  set logging file pidfile
  set logging on
  info proc
  set logging off
  shell lsof -p `cat pidfile | perl -n -e 'print $1 if /process (.+)/'`
end

document lsof
  List open files
end