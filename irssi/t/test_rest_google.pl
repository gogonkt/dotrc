use REST::Google::Search;
#binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
#binmode(STDERR, ':encoding(utf8)'); 

REST::Google::Search->http_referer('linuxfire.com.cn');

my $res=REST::Google::Search->new(
	q=>'美丽女孩',
	);

die "response status failure" if $res->responseStatus != 200;

my $data = $res->responseData;

# my $cursor = $data->cursor;
# #my $pages = $data->pages;
# 
# printf "current page index: %s\n", $cursor->currentPageIndex;
# printf "estimated result count: %s\n", $cursor->estimatedResultCount;

my @results = $data->results;

# foreach my $r (@results) {
# #printf "\n";
# printf "title: %s\n", $r->title;
# printf "url  : %s\n", $r->url;
# }

#printf "title: %s....$_" foreach @result;
printf $_->title.$_->url."\n" foreach @results;
