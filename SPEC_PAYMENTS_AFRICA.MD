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
