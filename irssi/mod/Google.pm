use strict;
#use warnings;
package Google;
use LWP::UserAgent;
use LWP::Simple;
use Data::Dumper;

sub _get_response{
    my $stext = shift;
    my $ua = LWP::UserAgent->new;
    return $ua->get('http://www.google.cn/search?ie=utf-8&oe=utf-8&q='.$stext,
                    'User-Agent' => 'HwGoogle 0.l',
                    'Accept-Charset' => 'utf-8',
                    'Accept-Language' => 'en-US');
}

sub search {
    my ($searchtext, $list_num) = @_;
    $list_num = 3 unless defined $list_num;

    my $response = _get_response($searchtext);
    if ($response->is_success) {
        my @rt;
        my $in_main = 0;
		#print Dumper($response->content);
		for my $url ($response->content =~ m:<a[^>]*href=\"([^\"]*)\"[^>]*class=l>:g) {
		next if $url =~ m:^/:g;
		next if $url =~ m:search:g;
		next if $url =~ m:translate.google.com:g;
		next if $url =~ m:google.com:g && !$in_main;
			++$in_main;
			push @rt,$url; 
			last if $in_main >= $list_num;
		};
		$_ = $response->content;
       	s:<font color=CC0033>::g ;
       	s:<\/font>::g ;
		$in_main = 0;
        my @title;
		for my $url (m:<a[^>]*class=l>([^<]*)</a>:g) {
		next if $url =~ m:^/:g;
		next if $url =~ m:search:g;
		next if $url =~ m:translate.google.com:g;
		next if $url =~ m:google.com:g && !$in_main;
			++$in_main;
			push @title,$url; 
			last if $in_main >= $list_num;
		};
		$in_main = 0;
		foreach (@rt){
			$rt[$in_main] = $rt[$in_main]." ".$title[$in_main]." " ;
			#$rt[$in_main] = $title[$in_main] . " \cc15" . $rt[$in_main] ."\cc01" ;
			++$in_main;
		}
        return @rt;
    }else{
        return ();
    }
}

sub whatis {
    my ($searchtext, $n) = @_;
    $n = 0 unless defined $n;
    $n = 0 if $n !~ m/^\d+$/;
    my $response = _get_response('define:'.$searchtext);
    if ($response->is_success){
        return ($response->content =~ m{<a (.+)</a>}g)[$n];
    }
    return undef;
}

1;

