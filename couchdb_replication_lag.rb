# Author: Navid Paya <me@navidpaya.com>
# This plguins needs the 'json' gem to be installed.
# On Debian, the package is called ruby-json.
# On CentOS, you need to install it manually.

class CouchDBReplicationLag < Scout::Plugin
  needs 'json'

  OPTIONS=<<-EOS
    master:
      name: CouchDB Master
    username:
      name: Username on the master
    password:
      name: Password on the master
  EOS

  def build_report
    db_list.each do |v|
      report(:db => v, :lag => calculate_lag(v))
    end
  end

  def calculate_lag(db)
    parsed_master_message = JSON.parse(`curl -s -k  https://'#{option(:username)}':'#{option(:password)}'@'#{option(:master)}':6984/#{db}/snmp_replication_doc`)
    parsed_slave_message = JSON.parse(`curl -s -k http://localhost:5984/#{db}/snmp_replication_doc`)
    master_timestap = parsed_master_message["write_time"]
    slave_timestamp = parsed_slave_message["write_time"]
    return (master_timestap.to_i - slave_timestamp.to_i)
  end

  def db_list
    all_dbs = JSON.parse(`curl -s http://localhost:5984/_all_dbs`)
    all_dbs.delete("_users")
    all_dbs.delete("_replicator")
    all_dbs.delete("bom")
    return all_dbs
  end

end
