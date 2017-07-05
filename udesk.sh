udesk_pid_file=tmp/pids/server.pid

function suitup-cd-udesk {
  cd ~/Documents/udesk_proj
}

function suitup-udesk-run {
  suitup-cd-udesk

  suitup-run "suitup-redis-run"
  suitup-run "rails server --daemon"
}

function suitup-udesk-kill {
  suitup-cd-udesk

  if [ ! -f $udesk_pid_file ]; then
    echo "Without $udesk_pid_file"
    return
  fi
  local pid=`cat $udesk_pid_file`

  suitup-run "kill -9 $pid"
  sudo rm tmp/pids/server.pid -f
}

function suitup-udesk-status {
  suitup-cd-udesk

  suitup-run "suitup-find-ps rails"

  if [ -f $udesk_pid_file ]; then
    suitup-run "cat $udesk_pid_file"
  fi
}

function suitup-udesk-db-reset {
  suitup-run 'rake db:drop'
  suitup-run 'rake db:create'
  suitup-run 'rake db:migrate'
  suitup-run 'rake db:seed'
  suitup-run 'rake seed:create_theme'
  suitup-run 'rake seed:create_second_theme'
  suitup-run 'rake seed:create_hc'
}