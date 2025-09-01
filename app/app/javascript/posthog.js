import posthog from 'posthog-js'

const posthog_api_key = import.meta.env.POSTHOG_API_KEY;

if (posthog_api_key) {
  posthog.init(posthog_api_key, {
    api_host: 'https://eu.i.posthog.com',
    defaults: '2025-05-24',
    capture_pageviews: false,
  })

  const phdid = document.getElementById('phdid').dataset.phdid;
  posthog.identify(phdid);

  console.log('posthog configured');
}
