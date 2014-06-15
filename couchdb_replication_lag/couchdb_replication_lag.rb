class CouchDBReplicationLag < Scout::Plugin
  needs 'json'

  OPTIONS=<<-EOS
    master:
      name: CouchDB Master
    username:
      name: Username on the master
    password:
      name: Password on the master
    document:
      name: Document to be monitored for lag
  EOS

  def build_report
    db_list.each do |v|
      report(:db => v, :lag => calculate_lag(v))
    end
  end

  def calculate_lag(db)
    parsed_master_message = JSON.parse(`curl -s -k  https://'#{option(:username)}':'#{option(:password)}'@'#{option(:master)}':6984/#{db}/#{option(:document)}`)
    parsed_slave_message = JSON.parse(`curl -s -k http://localhost:5984/#{db}/#{option(:document)}`)
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
