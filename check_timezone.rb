# Author: Navid Paya <me@navidpaya.com>
# This plguins checks if the timezone on your server matches
# your expected timezone. It returns 1 if not, so you could set
# a trigger for that.

class CheckTimeZone < Scout::Plugin

  OPTIONS=<<-EOS
    timezone:
      name: The timezone to check for
  EOS

  def status()
      current = `date +"%Z"`.chomp
      expected = option(:timezone)
      if current != expected
          return 1
      else
          return 0
      end
  end

  def build_report
    report(:status => status())
  end

end
