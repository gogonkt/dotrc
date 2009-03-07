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

$VERSION='0.1';

%IRSSI=(
	authors     =>  'Josh Kearney',
	name        =>  'IRC Bot',
	description =>  'Execute perl scripts through signal binds.',
	license     =>  'GPL',
	url         =>  'http://jk0.org/projects/irssi-scripts/'
);

sub public {
	my ($server,$msg,$nick,$address,$target)=@_;

	if($msg=~/^\.kernel/) {
		$_=get('http://www.kernel.org/kdist/finger_banner');
		my ($stable)=/.* stable version .* (2\.6\..+)/i;
		my ($old)=/2\.4 version .* (2\.4\..+)/i;
		$server->command('/MSG '.$target.' Linux: '.$stable.' ('.$old.')');
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

