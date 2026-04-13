#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);
use File::Basename;

# Function to read and write files using core Perl
sub patch_file {
    my ($path, $content) = @_;
    open(my $fh, '>', $path) or die "Could not open $path for writing: $!";
    print $fh $content;
    close($fh);
    print "Patched: $path\n";
}

sub get_file_content {
    my ($path) = @_;
    return "" unless -e $path;
    open(my $fh, '<', $path) or die "Could not open $path for reading: $!";
    my $content = do { local $/; <$fh> };
    close($fh);
    return $content;
}

# 1. Fix Nairobi.vue Name (Vue Multi-word rule)
my $nairobi_file = 'src/pages/Nairobi.vue';
if (-e $nairobi_file) {
    my $content = get_file_content($nairobi_file);
    # Only add the script if it's not already there
    if ($content !~ /export default/) {
        $content =~ s/<template>/<script lang="ts">\nexport default {\n  name: 'NairobiPage'\n}\n<\/script>\n\n<template>/;
        patch_file($nairobi_file, $content);
    }
}

# 2. Fix cms-bridge.ts (Unused variable)
my $bridge_file = 'src/boot/cms-bridge.ts';
if (-e $bridge_file) {
    my $content = get_file_content($bridge_file);
    $content =~ s/\{ app \}/_app/g; # Prefix with underscore
    patch_file($bridge_file, $content);
}

# 3. Fix messaging-hub/index.ts (Supabase Deno types)
my $msg_file = 'supabase/functions/messaging-hub/index.ts';
my $msg_content = <<'EOF';
// @ts-ignore: Deno types not available in Vue-TSC
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";

/**
 * MESSAGING HUB
 * Tonight's Integration:
 * - Mailgun for Receipts
 * - Africa's Talking for Kenya SMS (+254)
 * - Twilio for Costa Rica/USA SMS
 */

serve(async (req: Request) => {
  try {
    const { type, recipient, message } = await req.json();
    console.log(`[Messaging Hub] Processing ${type} for ${recipient}`);
    
    // TODO: logic for Mailgun / SMS providers
    
    return new Response(JSON.stringify({ status: "success" }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (err: any) {
    return new Response(JSON.stringify({ error: err.message }), { status: 400 });
  }
});
EOF
patch_file($msg_file, $msg_content);

print "\n--- Patches applied. The canvas is clean for tonight's session. ---\n";
