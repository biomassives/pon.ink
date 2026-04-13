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
