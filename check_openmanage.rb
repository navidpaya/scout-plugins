# This plguins relies on the check_openmanage executable to be placed
# in /usr/local/bin. Grab it from here:
# http://folk.uio.no/trondham/software/check_openmanage.html

class CheckOpenManage < Scout::Plugin

  def build_report
    check_openmanage_output = `/usr/local/bin/check_openmanage -s`
    lined_message = check_openmanage_output.split("<br/>")
    lined_message.each do |v|
       if v.split(" ")[0] != "OK"
         report(:warnings=> lined_message.count, :message => v)
       else
         report(:warnings=> 0, :message => v)
       end
    end
  end

end
