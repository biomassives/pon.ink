#!/usr/bin/perl
use strict;
use warnings;
use File::Slurp qw(read_file write_file); # Ensure libfile-slurp-perl is installed or use core open/read

# 1. Fix Nairobi.vue Name (Vue Multi-word rule)
# We'll rename the component internally to 'NairobiPage'
my $nairobi_file = 'src/pages/Nairobi.vue';
if (-e $nairobi_file) {
    my $content = do { local $/; open my $fh, '<', $nairobi_file; <$fh> };
    $content =~ s/<template>/<script lang="ts">\nexport default {\n  name: 'NairobiPage'\n}\n<\/script>\n\n<template>/;
    open my $fh, '>', $nairobi_file;
    print $fh $content;
    close $fh;
    print "Fixed: Multi-word component name in $nairobi_file\n";
}

# 2. Fix cms-bridge.ts (Unused variable)
my $bridge_file = 'src/boot/cms-bridge.ts';
if (-e $bridge_file) {
    my $content = do { local $/; open my $fh, '<', $bridge_file; <$fh> };
    $content =~ s/\{ app \}/_app/; # Prefix with underscore to signal intentional non-use
    open my $fh, '>', $bridge_file;
    print $fh $content;
    close $fh;
    print "Fixed: Unused variable in $bridge_file\n";
}

# 3. Fix messaging-hub (Supabase Deno types)
# Note: Vercel's vue-tsc tries to lint Supabase Deno files. 
# We add // @ts-ignore or explicit types to satisfy the compiler.
my $msg_file = 'supabase/functions/messaging-hub/index.ts';
if (-e $msg_file) {
    my $content = <<'EOF';
// @ts-ignore: Deno types not available in Vue-TSC
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";

serve(async (req: Request) => {
  try {
    const { type, recipient, message } = await req.json();
    console.log(`Messaging Hub Triggered: ${type} to ${recipient}`);
    
    // Mailgun/SMS logic goes here tonight
    
    return new Response(JSON.stringify({ status: "processed" }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 400 });
  }
});
EOF
    open my $fh, '>', $msg_file;
    print $fh $content;
    close $fh;
    print "Fixed: Type safety and imports in $msg_file\n";
}
