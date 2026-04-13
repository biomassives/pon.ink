#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);
use File::Basename;

sub patch_file {
    my ($path, $content) = @_;
    open(my $fh, '>', $path) or die "Could not open $path: $!";
    print $fh $content;
    close($fh);
    print "Bridged: $path\n";
}

my %bridge_map = (
    # 1. ROUTER WIRING
    'src/router/routes.ts' => <<'EOF',
import { RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { path: '', component: () => import('pages/IndexPage.vue') },
      { path: 'nairobi', component: () => import('pages/Nairobi.vue') },
      { path: 'audio-lab', component: () => import('pages/AudioLab.vue') },
      { path: 'sampler', component: () => import('pages/SampleManager.vue') },
    ],
  },
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue'),
  },
];

export default routes;
EOF

    # 2. STRIPE WEBHOOK (Supabase Edge Function)
    'supabase/functions/stripe-webhook/index.ts' => <<'EOF',
// STRIPE WEBHOOK HANDLER
// Tonight: Logic to unlock Sample Banks after successful KES/USD payment.
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";

serve(async (req) => {
  const signature = req.headers.get("stripe-signature");
  // TODO: Verify Stripe Signature
  // TODO: Update 'user_products' table in Postgres to unlock 'Afro-Latin Bank'
  
  return new Response(JSON.stringify({ received: true }), {
    headers: { "Content-Type": "application/json" },
  });
});
EOF
);

print "--- Finalizing Baseline Signal Chain ---\n";
foreach my $file_path (keys %bridge_map) {
    my $dir = dirname($file_path);
    make_path($dir) unless -d $dir;
    patch_file($file_path, $bridge_map{$file_path});
}
print "--- All systems wired. Ready for the deep dive. ---\n";
