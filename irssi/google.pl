# This script requires you to have your own Google API Developers Key, which you can request for free at: http://www.google.com/apis/
#
# Once you have aquired this key, use it for the $google_key variable.
#
# Usage:
#
# !google pleia2
#
# This does a google search for pleia2. The results will be displayed to you in a private message.


use Irssi;
use SOAP::Lite;

$VERSION = "1.0.3";
%IRSSI = (
    authors => 'pleia2',
    contact => 'lyz@princessleia.com ',
    name => 'googlebot',
    description => 'a bot that uses google API to query google',
    license => 'GNU GPL',
    url => 'http://www.princessleia.com/'
);

sub event_privmsg {
        my ($server, $data, $nick) =@_;
        my ($target, $text) = $data =~ /^(\S*)\s:(.*)/;
        return if ( $text !~ /^!/i );

if ( $text =~ /^!google /i )

	{

	my ($query) = $text =~ /!google (.*)/;

		my $google_key = 'YourKeyGoesHere';

		my $google_wdsl = "/home/r2d2/googleapi/GoogleSearch.wsdl";

		my $google_search = SOAP::Lite->service("file:$google_wdsl");
	
			my $results = $google_search ->
    				doGoogleSearch(
      				$google_key, $query, 0, 3, "false", "",  "false",
      				"", "latin1", "latin1"
    			);
			
		if ($results->{'estimatedTotalResultsCount'} != "0") {
			$server->command ( "msg $nick About $results->{'estimatedTotalResultsCount'} results results for your query. Displaying top:");
				foreach my $result (@{$results->{resultElements}}) {
					$server->command ( "msg $nick $result->{title}: $result->{URL}");
				}
		}
		else {
			$server->command ( "msg $nick sorry no results match your query");
		}
	}
}

Irssi::signal_add('event privmsg', 'event_privmsg');

