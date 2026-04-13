import type { RouteRecordRaw } from 'vue-router';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { 
        path: '', 
        component: () => import('pages/IndexPage.vue'),
        meta: { objective: 'Establish Zen-Ink aesthetic and consultancy authority.' }
      },
      {
        path: 'nairobi',
        component: () => import('pages/Nairobi.vue'),
        meta: {
          objective: 'Onboarding & Eco Ops: Educate, empower, and give voice to disempowered communities.',
        }
      },
      { 
        path: 'audio-lab', 
        component: () => import('pages/AudioLab.vue'),
        meta: { 
          objective: '440Hz Figure Calibration: High-velocity creative constraint.',
          requiresAudio: true 
        }
      },
      { 
        path: 'nairobi-checkout', 
        name: 'NairobiCheckout', 
        component: () => import('pages/NairobiCheckout.vue') 
      },
      { 
        path: 'sampler', 
        component: () => import('pages/SampleManager.vue'),
        meta: { 
          objective: 'Productization: Turning resonance into NFT soundbanks via Stripe.',
          requiresStripe: true 
        }
      },
    ],
  },
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue'),
  },
];

export default routes;
