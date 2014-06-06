# Author: Navid Paya <me@navidpaya.com>
# This plguins get a string from the Perl script, parses it
# and warns if there are underlyings with delay in OHLC populator.

class DelayedOHLCPopulator < Scout::Plugin

  def build_report
    delayed_ohlc_populator = `/usr/bin/bom_delayed_ohlc_populator.pm`
    delayed_ohlc_populator_list = delayed_ohlc_populator.split(", ")
    report("Number of delayed underlyings" => delayed_ohlc_populator_list.count)
    if delayed_ohlc_populator_list.count > 0
      alert('OHLC populator delayed', delayed_ohlc_populator)
    end
  end

end
