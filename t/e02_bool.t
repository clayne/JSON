use strict;

use Test::More;
use strict;

BEGIN { plan tests => 8 };

BEGIN { $ENV{PERL_JSON_BACKEND} ||= "JSON::backportPP"; }

use JSON;

my $json = new JSON;


is($json->encode([!1]),   '[""]');
if ($json->backend->isa('Cpanel::JSON::XS')) {
is($json->encode([!!2]), '[1]');
} else {
is($json->encode([!!2]), '["1"]');
}

is($json->encode([ 'a' eq 'b'  ]), '[""]');
if ($json->backend->isa('Cpanel::JSON::XS')) {
is($json->encode([ 'a' eq 'a'  ]), '[1]');
} else {
is($json->encode([ 'a' eq 'a'  ]), '["1"]');
}

is($json->encode([ ('a' eq 'b') + 1  ]), '[1]');
is($json->encode([ ('a' eq 'a') + 1  ]), '[2]');

# discard overload hack for JSON::XS 3.0 boolean class
#ok(JSON::true eq 'true');
#ok(JSON::true eq  '1');
ok(JSON::true == 1);
isa_ok(JSON::true, 'JSON::PP::Boolean');
#isa_ok(JSON::true, 'JSON::Boolean');



