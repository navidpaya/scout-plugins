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
