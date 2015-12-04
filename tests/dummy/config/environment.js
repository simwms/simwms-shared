/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'dummy',
    environment: environment,
    baseURL: '/',
    host: "http://localhost:4000",
    apiNamespace: "api",
    apiaNamespace: "apia",
    apixNamespace: "apix",
    apizNamespace: "apiz",
    locationType: 'auto',
    contentSecurityPolicy: { 
      "connect-src": "'self' ws://localhost:4000 https://*.amazonaws.com http://*.simwms.com https://*.herokuapp.com http://localhost:4000",
      "img-src": "*",
      "media-src": "'self' http://localhost:*",
      "font-src": "*",
      "style-src": "'self' 'unsafe-inline' *",
      "script-src": "'self' https://checkout.stripe.com",
      "frame-src": "'self' https://simwms.github.io https://checkout.stripe.com http://*.pisources.com"
    },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  return ENV;
};
