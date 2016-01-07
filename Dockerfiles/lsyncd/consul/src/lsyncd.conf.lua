--[[ http://habrahabr.ru/post/132098/ ]]
settings = {
  logfile    = "/home/app/log/lsyncd.log",
  statusFile = "/home/app/log/lsyncd.status",
  statusInterval = 5, --<== чтобы видеть что происходит без включения подробного лога
}

sync {
  default.rsyncssh,
  source = "/opt",
  host = "{{env "SYNC_HOST"}}",
  targetdir = "/opt",
  rsyncOpts = {"-ausS", "--temp-dir=/tmp"},
  delay = 3,
  rsync={
    compress=true,
    acls=true,
    verbose=true,
    rsh="/usr/bin/ssh -p {{env "SSHD_PORT"}} -o StrictHostKeyChecking=no"
  }
--[[,
  init = function(event) --<== перезагрузка функции инициализации. как она выглядела в оригинале можно посмотреть в документации или в исходниках
    log("Normal","Skipping startup synchronization...") --<== чтобы знать, что мы этот код вообще запускали и когда
  end
]]
}

