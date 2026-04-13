#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);

sub create_spec {
    my ($name, $content) = @_;
    open(my $fh, '>', $name) or die "Could not create $name: $!";
    print $fh $content;
    close($fh);
    print "Spec Inked: $name\n";
}

# 1. MAIN SPEC (The Vision)
create_spec('SPEC.MD', <<'EOF');
# pon.ink | Cross-Ghetto Collaboration Proposal
## Vision: Culture Intersecting Coding for the Human Spectrum

### Stakeholders
- **Fana Ka / OK Kulcha:** Sound Resonance & Street Media.
- **SCDHub Technical Group:** Water Cross-Connection Mapping (GIS/Postgres).
- **Health-Standard Group:** Open Source Health Cards (Decentralized ID).

### Core Infrastructure
- **Frontend:** Quasar / Vite (High Velocity).
- **Backend:** Supabase / Postgres (Relational Integrity).
- **Conduits:** Africa's Talking (SMS/M-Pesa) & Stripe (Global USD).
EOF

# 2. SOUND TOOLS (The Sampler & Moog Logic)
create_spec('SPEC_SOUNDTOOLS.MD', <<'EOF');
# SPEC: Sound Resonance Tools
- **Engine:** Web Audio API (Low Latency).
- **UI:** 16-Pad "Figure" Tribute Sampler.
- **Features:** X/Y Harmonic Calibration (440Hz base), Afro-Latin Bank (Congas/Timbales).
- **Goal:** Convert street recordings into Mintable NFT Sound Products.
EOF

# 3. LEGAL & EQUITY
create_spec('SPEC_LEGAL.MD', <<'EOF');
# SPEC: Legal & Equity Framework
- **Governance:** Open Source (MIT/GPL) for core tooling.
- **Data Sovereignty:** Users own their health and water-mapping data.
- **Revenue Split:** 80% Artist/Worker, 20% Community Infrastructure Fund.
- **Compliance:** GDPR/NDPA (Kenya Data Protection) for Health Cards.
EOF

# 4. PAYMENTS: AFRICA (M-Pesa)
create_spec('SPEC_PAYMENTS_AFRICA.MD', <<'EOF');
# SPEC: African Payment Conduits
- **Provider:** Africa's Talking / Safaricom M-Pesa.
- **Flow:** STK Push for "Resonance Unlocks."
- **Currency:** KES (Kenyan Shilling).
- **Logic:** 100 KES = 1 $BARS Token.
EOF

# 5. PAYMENTS: DOMESTIC (Stripe)
create_spec('SPEC_PAYMENTS_DOMESTIC.MD', <<'EOF');
# SPEC: Domestic/Global Payment Conduits
- **Provider:** Stripe.
- **Flow:** Elements / Checkout for Global Consultancy & Soundbank Sales.
- **Currency:** USD / EUR.
- **Integration:** Supabase Edge Function Webhooks for DB updates.
EOF

# 6. NFT & MINTING
create_spec('SPEC_NFT_MINTING.MD', <<'EOF');
# SPEC: NFT & On-Chain Certification
- **Network:** Polygon / Solana (Low Fee).
- **Use Case 1:** Soundbank Ownership (Licensing).
- **Use Case 2:** Health Card Verification (Encrypted Metadata).
- **Use Case 3:** Water Quality Certification (On-chain proof of testing).
EOF

print "\n--- All Specifications Stubbed. Documentation Baseline Ready. ---\n";
