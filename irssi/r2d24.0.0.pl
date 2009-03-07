use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "4.0.0";
%IRSSI = (
    authors => 'pleia2',
    contact => 'lyz@princessleia.com ',
    name => 'r2d2',
    description => 'r2d2 moderator bot for #13thHour',
    license => 'GNU GPL',
    url => 'http://www.princessleia.com/'
);

my @mom = ("pleia2");
my @dad = ("Time");
 
sub event_join {
  my ($server, $data, $nick, $host) = @_;
  my ($target) = $data =~ /^:(.*)/;
    return if ( $target !~ /#13thhour/i );
        foreach $mother (@mom ) {
            if ($nick =~ /^$mother$/i)  {
#               $server->command ( "mode $target +v $nick" );
               $server->command ( "MSG $target , . + * ^ * -,YAY! Hi Mommy!!! , . + * ^ * - ," );
}
}
        foreach $father (@dad ) {
            if ($nick =~ /^$father$/i)  {
#               $server->command ( "mode $target +v $nick" );
               $server->command ( "MSG $target , . + * ^ * -,YAY! Hi Time!!! , . + * ^ * - ," );

}
}
	if ($nick =~ /^BirthdayBot$/i) {
               $server->command ( "mode $target +o $nick" );
}
}
sub event_privmsg {
my ($server, $data, $nick, $mask, $target) =@_;
my ($target, $text) = $data =~ /^(\S*)\s:(.*)/;
    return if ( $text !~ /^!/i ); 
        if ($text =~ /^!help$|^!commands$/i ) {
        $server->command ("msg $nick \002My Commands Are:\002 !email, !webpage, !hug, !day, !date, !time, !tempcon C #, !tempcon F #, weighcon kg #, weightcon lb #, !lengthcon in #, !lengthcon cm # !weather zipcode (or country,city), !temp zipcode (or country,city), !country us (or any internet country code) !8-ball question?" )
}
        elsif ($text =~ /^!weather.*|^!google.*|^!temp.*|^!country.*|^!seen.*|^!lastspoke.*|^!code.*|^!state.*|^!pcode.*|^!cookies$|^!coffee$|^!email$|^!website$|^!chimay$|^!hug$|^!pepsi$|^!ice cream$|^!list$|^!tempcon.*|^!lengthcon.*|^!weightcon.*|^!day$|^!date$|^!time$|^!uptime$|^!8-ball$|^!8-ball.*\w$|^!8-ball..*\?$|^!8ball.*/i ) {
}
        elsif ($text =~ /^!8ball$/i ) {
        $server->command ( "msg $target You have to ask a question! Type !8ball your question?" );
}
        elsif ($text =~ /^!8ball.*\w$/i ) {
        $server->command ( "msg $target Your question must end with a question mark. Type !8ball your question? " );
}
        elsif ($text =~ /^!8ball..*\?$/i ) {
        $answer = $eightball[rand @eightball];
        $server->command ( "msg $target $answer" );
}
        elsif ($text =~ /^!join #*/i ) {
         my ($join) = $text =~ /^!join (#.*)/i;
          foreach $mother (@mom ) {
            if ($nick =~ /$mother$/i)  {
               $server->command ( "notice $nick joining $join" );
               $server->command ( "join $join" );
            }
     }
}
        elsif ($text =~ /^!part$/i ) {
          foreach $mother (@mom ) {
            if ($nick =~ /$mother$/i)  {
               $server->command ( "msg $target bye!" );
               $server->command ( "part $target" );
            }
     }
}
        elsif ($text =~ /^!identify$/i ) {
          foreach $mother (@mom ) {
            if ($nick =~ /$mother$/i)  {

#  elly@X-11DEFC50.dyn.optonline.net (fire)                                                                                                                                         
#  -!- Irssi: Starting query in fire with Logika
#  <Logika> hey
#  <Logika> I stumbled upon princessleia's website while looking for UT linux install instructions and found her r2d2 bot script
#  <Logika> it has its nickserv pass hard-coded into it
#  <Logika> $server->command ( "msg nickserv identify XXXXXXXXX" );
#  <Logika> kind of a bad mistake
#  <Time> Thank you for pointing that out, why are you exploiting it?
#  <Logika> I wanted to see if it was the real password
#  <Logika> so I wouldn't look like a dumbass if I brought it up
#  <Logika> if I were exploiting it I'd have identified to the nickname, hmm?
#  <Time> Well that's a pretty fucked up thing to do don't you think?
#  <Logika> Listen, I'm not trying to take your channel or anything
#  <Logika> I'm a random guy who noticed a problem, tried it out, and is now reporting it
#  <Time> Look, there are better ways to bring up bugs or oopses.
#   * Logika shrugs
#   <Time> Killing out bot is not one of them.
#   <Logika> see my comment re appearing to be a dumbass
#   <Time> :s/out/our
#   <Logika> well, anyway
#   <Logika> I'm going to disappear again
#   <Logika> sorry about killing it
#   <Time> I understand the severity of the problem, I'll bring it up with pl2, but the point is we haven't had a problem until now.
#   <Logika> but I couldn't think of another way to see if it was legit
#   <Logika> just because nobody has used a flaw doesn't mean it's not a flaw
#   <Time> Then you are very narrow minded.
#   <Time> you could have simply said someting.
#   <Logika> this is the script in question, by the way: http://www.princessleia.com/tools/r2d2/r2d24.0.0.pl
#   <Logika> anyway
#   <Logika> I'm leaving now
#   <Logika> bye
#   -!- Logika [elly@X-11DEFC50.dyn.optonline.net] has quit [Quit: vanished]

               $server->command ( "msg nickserv identify XXXpassXXX" );
            }
     }
}
        elsif ($text =~ /^!Time$/ ) {
          foreach $mother (@mom ) {
            if ($nick =~ /$mother$/i)  {
               $server->command ( "msg $target Mom!!!" );
            }
     }
}
        elsif ($text =~ /^!PrincessLeia2$|^!pleia2$/i ) {
          foreach $father (@dad ) {
            if ($nick =~ /$father$/i)  {
               $server->command ( "msg $target hehe $nick, you already HAVE pleia2" );
            }
     }
}
        elsif ($text =~ /^!myn$/i ) {
          foreach $mother (@mom ) {
            if ($nick =~ /^$mother$/i)  {
               $server->command ( "action $target gives $nick her Time" );
            }
     }
          foreach $father ( @dad ) {
            if ( $nick =~ /^$father$/i ) {
               $server->command ( "action $target gives $nick his pleia2" );
            }
     }
}

        else {
        my ($gimmie) = $text =~ /!(.*)/;
        $server->command ( "action $target Gets $nick $gimmie");
} 
}


Irssi::signal_add('event join', 'event_join');
Irssi::signal_add('event privmsg', 'event_privmsg');
