// eslint-disable-next-line
importScripts('/precache-manifest.26c69508c9191cfa0a0c7211cf2bfd19.js', 'https://storage.googleapis.com/workbox-cdn/releases/3.6.3/workbox-sw.js')

/**
  At the top of this file the 'workbox-webpack-plugin' will insert the following scripts

  // Google Workbox Library from a CDN
  e.g. importScripts("https://storage.googleapis.com/workbox-cdn/releases/3.6.3/workbox-sw.js");

  // Precache Manifest which has been created during build time
  e.g. importScripts("/precache-manifest.07afea1164a22a04c9f65b6e502c69f8.js");

  -------------------

  Currently the 'workbox-webpack-plugin' does not support the latest workbox version 4, but 3.6.3.
  The documentation of workbox v3.6.3 can be found here:
  https://developers.google.com/web/tools/workbox/reference-docs/v3.6.1/
 */


/* globals workbox */

const prefix = 'fleetyards'

workbox.core.setCacheNameDetails({
  prefix,
  suffix: 'v1',
  precache: 'precache',
  runtime: 'runtime',
})

/**
  What are the downsides to using skipWaiting and clientsClaim with Workbox?
  https://stackoverflow.com/questions/51715127
*/
workbox.skipWaiting()
workbox.clientsClaim()

/**
  The manifest (created by webpack) adds a list of URLs to self.__precacheManifest.
  This includes all created chunk for lazy-loaded components and the entry file.

  These files will be precached.
*/
// eslint-disable-next-line no-underscore-dangle, no-restricted-globals
workbox.precaching.precacheAndRoute(self.__precacheManifest)


/**
  -------------------------------------
  RUNTIME CACHES
  -------------------------------------
*/

workbox.routing.registerRoute(
  ({ event }) => event.request.destination === 'document',
  new workbox.strategies.NetworkFirst({
    cacheName: `${prefix}-pages`,
    networkTimeoutSeconds: 3,
    plugins: [
      new workbox.expiration.Plugin({
        maxEntries: 60,
        maxAgeSeconds: 30 * 24 * 60 * 60, // 30 Days
      }),
    ],
  }),
)

/**
  CSS
*/
workbox.routing.registerRoute(
  /\.[a-f0-9]{8}\.css$/i,
  workbox.strategies.cacheFirst({
    cacheName: `${prefix}-css`,
    plugins: [
      new workbox.expiration.Plugin({
        maxAgeSeconds: 7 * 24 * 3600, // 1 week
        purgeOnQuotaError: false,
      }),
    ],
  }), 'GET',
)

/**
  Images
*/
workbox.routing.registerRoute(
  /\.[a-f0-9]{8}\.(?:png|gif|jpg|jpeg|svg|webp)$/i,
  workbox.strategies.cacheFirst({
    cacheName: `${prefix}-images`,
    plugins: [
      new workbox.expiration.Plugin({
        maxAgeSeconds: 7 * 24 * 3600, // 1 week
        purgeOnQuotaError: false,
      }),
    ],
  }), 'GET',
)

/**
  Fonts
*/
workbox.routing.registerRoute(
  /\.[a-f0-9]{8}\.(woff2?|eot|ttf|otf)(\?.*)?$/i,
  workbox.strategies.cacheFirst({
    cacheName: `${prefix}-fonts`,
    plugins: [
      new workbox.expiration.Plugin({
        maxAgeSeconds: 7 * 24 * 3600, // 1 week
        purgeOnQuotaError: false,
      }),
    ],
  }), 'GET',
)

/**
  Google-Fonts
*/
workbox.routing.registerRoute(
  /https:\/\/fonts.(?:googleapis|gstatic).com\/(.*)/i,
  workbox.strategies.cacheFirst({
    cacheName: `${prefix}-google-fonts`,
    plugins: [
      new workbox.expiration.Plugin({
        maxEntries: 20,
        purgeOnQuotaError: false,
      }),
    ],
  }), 'GET',
)
