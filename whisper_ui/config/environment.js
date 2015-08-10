/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'whisper-ui',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },
    contentSecurityPolicy: {
      'font-src': "'self' data: fonts.gstatic.com",
      'style-src': "'self' 'unsafe-inline' fonts.googleapis.com",
      'connect-src': "'self' http://localhost:3000"
    }
  };

  ENV['simple-auth'] = {
    authorizer: 'simple-auth-authorizer:token',
    crossOriginWhitelist: ['http://localhost:3000']
  }

  // ENV['simple-auth-token'] = {
  //   serverTokenEndpoint: 'http://localhost:3000/api/v1/login',
  //   // dentificationAttributeName: 'identification',
  //   // tokenAttributeName: 'token',
  //   identificationField: 'identification',
  //   passwordField: 'password',
  //   tokenPropertyName: 'token',
  //   // authorizationPrefix: '',
  //   authorizationHeaderName: 'Token',
  //   headers: {},
  //   refreshAccessTokens: true,
  //   serverTokenRefreshEndpoint: 'http://localhost:3000/api/v1/refresh_token',
  //   tokenExpireName: 'exp',
  //   refreshLeeway: 100,
  //   timeFactor: 1000  // example - set to "1000" to convert incoming seconds to milliseconds.
  // };


  ENV['simple-auth-token'] = {
    serverTokenEndpoint: 'http://localhost:3000/api/v1/login',
    serverTokenRefreshEndpoint: 'http://localhost:3000/api/v1/refresh_token',
    identificationField: 'identification',
    passwordField: 'password',
    tokenPropertyName: 'token',
    authorizationPrefix: null,
    authorizationHeaderName: 'Token',
    timeFactor: 1000,
    refreshLeeway: 5,
    tokenExpireName: 'exp',
  };

  if (environment === 'development') {
    ENV.APP.LOG_TRANSITIONS = true;

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
