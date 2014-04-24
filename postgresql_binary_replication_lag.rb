# Author: Kaveh Mousavi Zamani <kavehmz@gmail.com>
# This is plugin to return a huge lag if you add it
# to a master PostgreSQL instance by mistake. It monitors
# the last replayed transaction on the slave which is good
# enough for our use case.

class PostgresBinaryReplicationLag < Scout::Plugin
  OPTIONS=<<-EOS
    username:
      name: Username
    password:
      name: Password
  EOS

  def build_report
    replication_delay = `psql postgresql://#{option(:username)}:#{option(:password)}@localhost/postgres?sslmode=require -A -c "select coalesce(EXTRACT('epoch' FROM now() - pg_last_xact_replay_timestamp()), 0.0) as lag" -S -t --field-separator=' '`
    puts replication_delay
    if replication_delay.chomp == ""
      report(:replication_delay_seconds => 1000000)
    else
      report(:replication_delay_seconds => replication_delay.chomp)
    end
  end
end
