# Author: Navid Paya <me@navidpaya.com>
# This plguins get a string from the Perl script, parses it
# and warns if there are underlyings with delay in tick populator.

class DelayedTickPopulator < Scout::Plugin

  def build_report
    delayed_tick_populator = `cat /tmp/scout-delayed-tick-populator`
    delayed_tick_populator_list = delayed_tick_populator.split(", ")
    report("Number of delayed underlyings" => delayed_tick_populator_list.count)
    if delayed_tick_populator_list.count > 0
      alert('Tick populator delayed', delayed_tick_populator)
    end
  end

end
