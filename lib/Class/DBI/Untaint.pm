package Class::DBI::Untaint;

$VERSION = '0.01';

use strict;

use CGI::Untaint;
use Class::DBI;

sub Class::DBI::_constrain_by_untaint {
	my ($class, $col, $string, $type) = @_;
	$class->add_constraint(
		untaint => $col => sub {
			CGI::Untaint->new({ $col => +shift })->extract("-as_$type" => $col);
		});
}

=head1 NAME

Class::DBI::Untaint - Class::DBI constraints using CGI::Untaint

=head1 SYNOPSIS

	use base 'Class::DBI';
  use Class::DBI::Untaint;

	___PACKAGE__->columns(All => qw/id value entered/);
	___PACKAGE__->constrain_column(value => Untaint => "integer");
	___PACKAGE__->constrain_column(entered => Untaint => "date");

=head1 DESCRIPTION

Using this module will plug-in a new constraint type to Class::DBI that
uses CGI::Untaint.

Any column can then be said to require untainting of a given type -
i.e. that any value which you attempted to set that column to (include
at create() time) must pass an untaint as_type() check.

In the examples above, the 'value' column must pass the check in
CGI::Untaint::integer, and similarly 'entered' must untaint as a date.

=head1 SEE ALSO

L<Class::DBI>, L<CGI::Untaint>.

=head1 AUTHOR

Tony Bowden, E<lt>kasei@tmtm.comE<gt>. 

=head1 COPYRIGHT

Copyright (C) 2004 Tony Bowden. All rights reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
