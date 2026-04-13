#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);
use File::Basename;

sub patch_file {
    my ($path, $content) = @_;
    my $dir = dirname($path);
    make_path($dir) unless -d $dir;
    open(my $fh, '>', $path) or die "Could not open $path: $!";
    print $fh $content;
    close($fh);
    print "Bootstrapped: $path\n";
}

my %boot_map = (
    # 1. THE SUPABASE CLIENT BOOT
    # Note: We escape the @ sign so Perl doesn't look for an array
    'src/boot/supabase.ts' => <<'EOF',
import { boot } from 'quasar/wrappers';
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL || 'https://your-project.supabase.co';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || 'your-anon-key';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export default boot(({ app }) => {
  app.config.globalProperties.$supabase = supabase;
});
EOF
);

print "--- Fixing Vite Import Error: boot/supabase ---\n";
foreach my $file_path (keys %boot_map) {
    patch_file($file_path, $boot_map{$file_path});
}

print "\n--- RECOVERY STEPS ---\n";
print "1. Run: npm install \@supabase/supabase-js\n";
print "2. Add 'supabase' to the 'boot' section in quasar.config.ts\n";
