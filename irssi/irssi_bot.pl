# irssi-bot.pl - Irssi Bot
#
# Copyright (c) 2006, Josh Kearney
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY JOSH KEARNEY ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL JOSH KEARNEY BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

use Irssi;
use strict;
use vars qw($VERSION %IRSSI);

use LWP::Simple;
use REST::Google::Search;
use HTML::Entities;

binmode(STDOUT, ':encoding(utf8)');

require("mod/Google.pm");

$VERSION='0.1';

%IRSSI=(
	authors     =>  'gogonkt',
	name        =>  'irssi IRC Bot',
	description =>  'Execute perl scripts through signal binds.',
	license     =>  'GPL',
	url         =>  ''
);

sub public {
	my ($server,$msg,$nick,$address,$target)=@_;

	if($msg=~/^\.help$/) {##
		$server->command('/MSG '.$target.
			' 目前 Luna 这个机器人支持的指令: .help 手册 .kernel,查询内核版本 .g google搜索 .st 查询电台状态 .i !index'
			.' .t 查询目前房间 .cpan 搜索CPAN .bugs 搜索gentoo的bugs报告'
			);
	}

	elsif($msg=~/^\.kernel$/) {##
		$_=get('http://www.kernel.org/kdist/finger_banner');
		my ($stable)=/.* stable version .* (2\.6\..+)/i;
		my ($old)=/2\.4 version .* (2\.4\..+)/i;
		$server->command('/MSG '.$target.' Linux内核: stable '.$stable.' ( old stable '.$old.' )');
	}

#	elsif($msg=~/^\.st$/i or $msg=~/^st$/i) {##
#        if($target=~/#linuxfire/i){
#		$server->command('/MSG '.$target.' 电台已经转到#LFR,快点过来和DJ互动吧');
#        }
#        elsif($target=~/#lfr/i){
#		$server->command('/MSG -fire #LFR r点歌台 st');
#        }
#	}

#	elsif($msg=~/^\.i$/) {##
#		$server->command('/MSG '.$target.' !index');
#	}

	elsif($msg=~/^\.t$/) {##
		$server->command('/MSG '.$target.' now at '.$target);
	}

	elsif($msg=~/^\.g/) {##
		if($msg=~/^\.g help/){
			$server->command('/MSG '.$target.' google 搜索,".g 关键字"');
		}
		else{
			my ($query)=$msg=~/.g (.*)/;

				REST::Google::Search->http_referer('linuxfire.com.cn');
				my $res=REST::Google::Search->new(
					q=>$query,
					); die "response status failure" if $res->responseStatus != 200;
				my $data = $res->responseData;
				my @results = $data->results;
				# $server->command('/MSG '.$target.' '.$_->title.' '.$_->url) foreach @results;
				
				foreach my $r (@results){
				my $tmp=$r->title;
				$tmp=~ s/<(.*?)>//gi;
				$tmp=decode_entities($tmp);
				$server->command('/MSG '. $target. ' '. $tmp. " ". $r->url. "\n");
				}



			## BUGS Use of uninitialized value in concatenation (.) or string at /home/gogonkt/.irssi/scripts/mod/Google.pm line 52.
			## 这是warning of Google.pm 关了 'use warning' 可以临时解决, 出现在网站标题分解不出的时候
			# $server->command('/MSG '.$target.' '.join(' ',Google::search($query)));
		}
	}

	elsif($msg=~/^\.bugs/) {##
		my ($query)=$msg=~/.bugs (.*)/;
		$server->command('/MSG '.$target.' ~google for '.$query.' site:bugs.gentoo.org');
	}

	elsif($msg=~/^\.cpan/) {##
		my ($query)=$msg=~/.cpan (.*)/;
		$server->command('/MSG '.$target.' g '.$query.' site:search.cpan.org');
	}
}


sub private {
	my ($server,$msg,$nick,$address)=@_;
	public($server,$msg,$nick,$address,$nick);
}

sub own_public {
	my ($server,$msg,$target)=@_;
	public($server,$msg,$server->{nick},0,$target);
}

sub own_private {
	my ($server,$msg,$target,$otarget)=@_;
	public($server,$msg,$server->{nick},0,$target);
}

Irssi::signal_add_last('message public','public');
Irssi::signal_add_last('message private','private');
Irssi::signal_add_last('message own_public','own_public');
Irssi::signal_add_last('message own_Private','own_private');

