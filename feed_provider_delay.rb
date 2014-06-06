# Author: Navid Paya <me@navidpaya.com>
# This plguins checks creates a list of feed providers based on ymal
# files and then find the lag for each of those providers and reports
# it to scout.

class FeedProviderDelapy < Scout::Plugin
  needs 'json'

  def build_report
    provider_list = JSON.parse(`/usr/bin/bom_provider_delay.pm --list-used-providers`)
    provider_list.each do |v|
     provider_lag = `/usr/bin/bom_provider_delay.pm #{v}`
         report("Delay for #{v}" => provider_lag)
    end
  end

end
