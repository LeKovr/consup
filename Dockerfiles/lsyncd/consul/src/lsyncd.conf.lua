--[[ http://habrahabr.ru/post/132098/ ]]
settings {
  logfile    = "/home/app/log/lsyncd.log",
  statusFile = "/home/app/log/lsyncd.status",
  statusInterval = 5,
  nodaemon   = true,
}

sync {
  default.rsyncssh,
  source = "/opt",
  host = "{{env "SYNC_HOST"}}",
  targetdir = "/opt/",
  delay = 3,
  rsync = {
    archive=true,
    compress=true,
    acls=true,
    verbose=true,
    temp_dir="/tmp",
    update=true,
    links=true,
    times=true,
    protect_args=true
  },
  ssh = {
    port = {{env "SSHD_PORT"}}
  },
--[[,
  init = function(event) --<== перезагрузка функции инициализации. как она выглядела в оригинале можно посмотреть в документации или в исходниках
    log("Normal","Skipping startup synchronization...") --<== чтобы знать, что мы этот код вообще запускали и когда
  end
]]
}

