package Koha::Plugin::Com::ByWaterSolutions::Pika::ApiController;

# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use Modern::Perl;

use Mojo::Base 'Mojolicious::Controller';

use Koha::Holds;

=head1 API

=head2 Class Methods

=head3 Method that bothers the patron, with no side effects

=cut

sub hold_suspend {
    my $c = shift->openapi->valid_input or return;

    my $hold_id = $c->validation->param('hold_id');
    my $hold = Koha::Holds->find( $hold_id );

    unless ($hold) {
        return $c->render( status => 404, openapi => { error => "Hold not found." } );
    }

    $hold->suspend_hold();

    return $c->render( status => 200, openapi => { suspended => Mojo::JSON->true } );
}

sub hold_resume {
    my $c = shift->openapi->valid_input or return;

    my $hold_id = $c->validation->param('hold_id');
    my $hold = Koha::Holds->find( $hold_id );

    unless ($hold) {
        return $c->render( status => 404, openapi => { error => "Hold not found." } );
    }

    $hold->resume();

    return $c->render( status => 200, openapi => { resumeed => Mojo::JSON->true } );
}

1;
