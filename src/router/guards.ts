// src/router/guards.ts
import type { Router } from 'vue-router';
import { supabase } from 'boot/supabase'; // Assuming you have a supabase boot file

export function setupGuards(router: Router) {
  router.beforeEach(async (to, from, next) => {
    // 1. Context Logging
    if (to.meta.objective) {
      console.log(`[pon.ink] Objective: ${to.meta.objective as string}`);
    }

    // 2. The M-Pesa / Stripe Intersection
    if (to.meta.requiresPayment) {
      const { data: profile } = await supabase.from('profiles').select('currency, has_access').single();

      if (!profile?.has_access) {
        const isNairobi = profile?.currency === 'KES' || to.path.includes('nairobi');
        return next({ 
          name: isNairobi ? 'NairobiCheckout' : 'StripeCheckout', 
          query: { redirect: to.fullPath } 
        });
      }
    }
    next();
  });
}
