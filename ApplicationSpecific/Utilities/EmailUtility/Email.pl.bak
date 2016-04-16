# send_attachment.pl
# ----------------------------------------------------------------------
#
# File:       EmailUtility.pl
#
# Autor:      Udita Dube / 28.02.2011
#
# Purpose:    Email attachments in Perl
#
# Location:   
#
# ----------------------------------------------------------------------

#!/usr/local/bin/perl -w

 use Net::SMTP;
 use MIME::Lite;
 use DirHandle;
$"='';
## Adjust sender, recipient and your SMTP mailhost
my $Host = "ps0672.persistent.co.in";
my $MailFrom = 'admin@persistent.com';
my $MailTo = 'udita_dube@persistent.co.in,test_1@persistent.co.in';
my $MailCC = 'test_email@persistent.co.in';

my($day, $month, $year)=(localtime)[3,4,5];
$Date= "$day-".($month+1)."-".($year+1900);

my $testcase_result = "D:/Quicken/ApplicationSpecific/Data/TestData/TestCaseResult.txt";

if(-f "C:/LatestBuild.txt")
{
	open FILE, 'C:/LatestBuild.txt';
	$BuildNo = <FILE>;
	close FILE;
}

open (FH,$testcase_result);
if (grep{/FAILED/} <FH>)
{
   $result= "FAILED";
}
else
{
    $result= "PASSED";
}
close (FH);

### Attachment
my $dir = 'D:/Quicken/Log';
my $MailSubject = "Acceptance test $result for QA build : $BuildNo dated : $Date";
my $message_body = "
--------------------------------------------------------------------------
		Acceptance Test 

 		Result:- Acceptance test $result for QA build : $BuildNo
		Date:-	 $Date
--------------------------------------------------------------------------
		
Please find the attached log file and complete test results are as follows:";

my $dir_handle = new DirHandle $dir or die "unable to open $dir $!";
my %newest;
$newest{mtime} = 0;
while (defined($file = $dir_handle->read)) 
{
   next if ($file eq '.' or $file eq '..');
   my $mtime = (stat("$dir/$file"))[9];
   $newest{file} = $file and $newest{mtime} = $mtime if $newest{mtime} < $mtime;
}

my $log_file = "$dir"."/"."$newest{file}";

$attachment_name=$newest{file};


$msg = MIME::Lite->send('smtp', $Host, Timeout=>60);
### Create the multipart container
$msg = MIME::Lite->new (
  From => $MailFrom,
  To => $MailTo,
  CC => $MailCC,
  Subject => $MailSubject,
  Type =>'multipart/mixed'
  ) or die "Error creating multipart container: $!\n";

if(-f "$testcase_result")
	{
		open FH,"$testcase_result";
		@txt =  <FH>;
		$msg-> attach(Type => 'Text',
					  Data => "$message_body"."\n\n"."@txt\n"); 
		close FH;
	}
	else
	{
		die "\nTestcase Result File is not Found\n";
	}

# Add Attachment to the Mail
$msg->attach (
  Type => 'TEXT',
  Path => $log_file,
  Filename => $attachment_name,
  Disposition => 'attachment'
) or die "Error adding the text message part: $!\n";

$msg->send; 






	
	