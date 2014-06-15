## Author: Navid Paya <me@navidpaya.com>             
This plguins needs the 'json' gem to be installed.                                               
On Debian, the package is called ruby-json.       
On CentOS, you need to install it manually.
## How It Works
CouchDB has no built-in mechanism of checking lag.
So we basically ask the plugin to keep an eye on a certain
document and compare the epoch betweein master and slave.
