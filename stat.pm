package VMS::Stat;

use strict;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter AutoLoader DynaLoader);

# This allows declaration	use VMS::Stat qw( &vmsmkdir );
# as well as 			use VMS::Stat ':all';
my %EXPORT_TAGS = ( 'all' => [ qw( &vmsmkdir ) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

@EXPORT = ();

$VERSION = '0.01';

bootstrap VMS::Stat $VERSION ;

1;
__END__

=head1 NAME

VMS::Stat - Perl extension for access to HP C extensions to the mkdir() function in the C RTL.

=head1 SYNOPSIS

  use VMS::Stat qw(&vmsmkdir);
  vmsmkdir( 'SYS$DISK:[.MARS]',0777,,1 ); # Equivalent to DCL: $ create/directory/version_limit=1 [.MARS]

=head1 DESCRIPTION

=over 4

=item vmsmkdir

The C<vmsmkdir> function enables you to specify optional RMS arguments
to the VMS CRTL when creating a directory.  Its operation is similar to the built-in
Perl C<mkdir> function (see L<perlfunc> for a complete description).
Up to 4 optional arguments may follow the directory name.  These arguments should 
be numbers which specify optional directory characteristics as allowed by the CRTL. 
(See the CRTL reference manual description of mkdir() and chmod() for details.)
If successful, C<vmsmkdir> returns a true value;
error occurs, it returns C<undef>.

Directory characteristic options:

=over 2

=item mode

A file protection.

=item uic

The user identification code that identifies the owner of the created directory.

=item max_versions

The maximum number of file versions to be retained in the created directory.

=item r_v_number

The volume or device on which to place the created directory if the device
is part of a volume set.

=back

=back

=head1 HISTORY

=over 8

=item 0.01

Original version; created by h2xs 1.22 with options -C -c -n VMS::Stat stat.h

=back


=head1 SEE ALSO

The VMS::Stdio extension provides VMS::Stdio::vmsopen() as
an interface to the C RTL's fopen() funciton.

=head1 AUTHOR

Peter Prymmer, E<lt>pprymmer@best.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Peter Prymmer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
