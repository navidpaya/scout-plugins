Find the source code visit <https://github.com/navidpaya/scout-plugins>.
## External Dependency
This plguins relies on the check_openmanage executable to be placed
in /usr/local/bin. Grab it from here:
<http://folk.uio.no/trondham/software/check_openmanage.html>
I initially intended to implement the monitoring using SNMP but just
a glance at the the Dell MIB reference changed my mind.
## How It Works
The good news is you don't need SNMP. This plugins works as long
as omreport works. It will report the nummer of errors and send the
errors themselves as internal alerts (meaning you will see them in scout
itself but not in, let's say PagerDuty.
