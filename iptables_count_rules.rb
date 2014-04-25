# Author: Sayed M. Mahdi Sadrnezhaad <smmsadr@gmail.com>
# This plugins counts the iptables rules and reports it to the scout.

class IPtables < Scout::Plugin

  def build_report
    user =  %x[/usr/bin/sudo /sbin/iptables-save > /tmp/iptables-rules]
    iptablesCount = %x[wc -l /tmp/iptables-rules | cut -f1 -d' '].to_i
    report(:rules=> iptablesCount)
  end

end
