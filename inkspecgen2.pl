#!/usr/bin/perl
use strict;
use warnings;

sub update_spec {
    my ($name, $content) = @_;
    open(my $fh, '>', $name) or die "Could not update $name: $!";
    print $fh $content;
    close($fh);
    print "Infrastructure Spec Refined: $name\n";
}

# 1. ENHANCED SPEC: PAYMENTS AFRICA (M-Pesa)
update_spec('SPEC_PAYMENTS_AFRICA.MD', <<'EOF');
# TECHNICAL SPEC: M-Pesa / Africa's Talking Bridge (Infra & Compliance)

## 1. Cost Structure & Transparency
- **Transaction Fee:** Safaricom/AT baseline (~3-5% per STK Push).
- **The "Resonance" Split:** - 80% to Artist Wallet.
    - 15% to Community Hardware Fund (WATSAN/Mapping).
    - 5% to Platform Maintenance.
- **UI Requirement:** Display the "Net to Artist" value in KES *before* the user hits "Confirm."

## 2. Infrastructure for Compliance
- **Audit Log:** Every STK Push attempt must be logged in `mpesa_audit` table with `provider_request_id` before the user sees the prompt.
- **Anti-Fraud:** Rate-limiting via Supabase Edge Functions (max 3 STK Pushes per 5 minutes per Phone Number).
- **Data Residency:** All Kenyan PII (Phone numbers) stored in encrypted columns to comply with Kenya's Data Protection Act (NDPA).

## 3. Transparency Bridge
- **On-Chain Sync:** Post-callback, a "Receipt Hash" is generated. While the transaction is KES, the *proof of support* is minted as a gasless metadata update on the user's $BARS ID.
EOF

# 2. ENHANCED SPEC: PAYMENTS DOMESTIC (Stripe)
update_spec('SPEC_PAYMENTS_DOMESTIC.MD', <<'EOF');
# TECHNICAL SPEC: Stripe / Domestic Bridge (Infra & Compliance)

## 1. Cost Structure & Transparency
- **Stripe Fee:** 2.9% + 30¢ (Standard Domestic).
- **The "Consultancy" Split:**
    - 70% to Project Lead/SCDHub Node.
    - 20% to Global Open Source Tooling Fund.
    - 10% to Stripe/Platform overhead.
- **Invoice Transparency:** Automated PDF generation via Stripe Invoicing for consultancy clients.

## 2. Infrastructure for Compliance
- **PCI Compliance:** Zero storage of Card Data. Use Stripe Elements exclusively.
- **KYC/AML:** Integrate Stripe Identity if "Patron" level exceeds $1,000 USD to ensure compliance with international "Know Your Customer" standards.
- **Webhook Security:** Mandatory `stripe-signature` verification in the Supabase Edge Function to prevent replay attacks.

## 3. Transparency Bridge
- **Public Ledger:** A sanitized version of the `community_fund` (showing amounts and project impact, but hiding PII) is visible in the **Worldbridger One** dashboard for radical transparency.
EOF

print "--- Technical Infrastructure Specs Deployed ---\n";
