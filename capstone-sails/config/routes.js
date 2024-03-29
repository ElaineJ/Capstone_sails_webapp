/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes tell Sails what to do each time it receives a request.
 *
 * For more information on configuring custom routes, check out:
 * https://sailsjs.com/anatomy/config/routes-js
 */


module.exports.routes = {


  //  ╦ ╦╔═╗╔╗ ╔═╗╔═╗╔═╗╔═╗╔═╗
  //  ║║║║╣ ╠╩╗╠═╝╠═╣║ ╦║╣ ╚═╗
  //  ╚╩╝╚═╝╚═╝╩  ╩ ╩╚═╝╚═╝╚═╝
  'GET /':                   { action: 'view-homepage-or-redirect' },


  'GET /welcome':            { action: 'dashboard/view-welcome' },

  'GET /faq':                { view:   'pages/faq' },
  'GET /legal/terms':        { view:   'pages/legal/terms' },
  'GET /legal/privacy':      { view:   'pages/legal/privacy' },
  'GET /contact':            { view:   'pages/contact' },

  'GET /signup':             { action: 'entrance/view-signup' },
  'GET /email/confirm':      { action: 'entrance/confirm-email' },
  'GET /email/confirmed':    { view:   'pages/entrance/confirmed-email' },

  'GET /login':              { action: 'entrance/view-login' },
  'GET /password/forgot':    { action: 'entrance/view-forgot-password' },
  'GET /password/new':       { action: 'entrance/view-new-password' },

  'GET /account':            { action: 'account/view-account-overview' },
  'GET /account/password':   { action: 'account/view-edit-password' },
  'GET /account/profile':    { action: 'account/view-edit-profile' },

  'GET /scheduler/ranked-cases': { action: 'scheduler/view-ranked-cases' },



  //  ╔═╗╔═╗╦  ╔═╗╔╗╔╔╦╗╔═╗╔═╗╦╔╗╔╔╦╗╔═╗
  //  ╠═╣╠═╝║  ║╣ ║║║ ║║╠═╝║ ║║║║║ ║ ╚═╗
  //  ╩ ╩╩  ╩  ╚═╝╝╚╝═╩╝╩  ╚═╝╩╝╚╝ ╩ ╚═╝
  // Note that, in this app, these API endpoints may be accessed using the `Cloud.*()` methods
  // from the CloudSDK library.
  '/api/v1/account/logout':                           { action: 'account/logout' },
  'PUT   /api/v1/account/update-password':            { action: 'account/update-password' },
  'PUT   /api/v1/account/update-profile':             { action: 'account/update-profile' },
  'PUT   /api/v1/account/update-billing-card':        { action: 'account/update-billing-card' },
  'PUT   /api/v1/entrance/login':                        { action: 'entrance/login' },
  'POST  /api/v1/entrance/signup':                       { action: 'entrance/signup' },
  'POST  /api/v1/entrance/send-password-recovery-email': { action: 'entrance/send-password-recovery-email' },
  'POST  /api/v1/entrance/update-password-and-login':    { action: 'entrance/update-password-and-login' },
  'POST  /api/v1/deliver-contact-form-message':          { action: 'deliver-contact-form-message' },

  //
  //
  //
  // TODO remove all above



  // PATIENTS
  'GET /api/v1/patients/fetch': { action: 'patients/fetch' },
  'POST /api/v1/patients/login': { action: 'patients/login' },
  'POST /api/v1/patients/register': { action: 'patients/register' },
  'GET /api/v1/patients/list': { action: 'patients/list' },



  // GPs
  'POST /api/v1/gps/login': { action: 'gps/login' },
  'POST /api/v1/gps/register': { action: 'gps/register' },

  //'POST /api/v1/provider/register': { action: 'register-provider' },


  // Consultants
  'POST /api/v1/consultants/login': { action: 'consultants/login' },
  'POST /api/v1/consultants/register': { action: 'consultants/register' },

  // referrals
  'GET /api/v1/referral/get': { action: 'referral/get' },
  'POST /api/v1/referral/submit': { action: 'referral/submit' },

  'GET /api/v1/gps/get': { action: 'gps/get' },
  'GET /api/v1/gps/list': { action: 'gps/list' },
  'GET /api/v1/consultants/get': { actions: 'consultants/get' },
  'GET /api/v1/consultants/list': { action: 'consultants/list' },

  // advice
  'GET /api/v1/advice/list': { action: 'advice/list' },
  'GET /api/v1/advice/get': { action: 'advice/get' },
  'POST /api/v1/advice/set': { action: 'advice/set' },

  // messenger
  'POST /api/v1/messenger/post': { action: 'messenger/post' },
  'GET /api/v1/messenger/fetch': { action: 'messenger/fetch' },
  'GET /api/v1/messenger/list': { action: 'messenger/list' },


  // notifications
  'POST /api/v1/notifications/push-token': { action: 'notifications/push-token' },
  'POST /api/v1/notifications/push-notification': { action: 'notifications/push-notification' },

  // State persistence
  'GET /api/v1/persistence/get-consultant-on-duty': { action: 'persistence/get-consultant-on-duty' },
  'POST /api/v1/persistence/set-consultant-on-duty': { action: 'persistence/set-consultant-on-duty' },
  'GET /api/v1/persistence/get-assigned-consultant': { action: 'persistence/get-assigned-consultant' },
  'POST /api/v1/persistence/set-assigned-consultant': { action: 'persistence/set-assigned-consultant' },


  // query cases
  'GET /api/v1/querycases/get': { action: 'querycases/get' },

  //  ╦ ╦╔═╗╔╗ ╦ ╦╔═╗╔═╗╦╔═╔═╗
  //  ║║║║╣ ╠╩╗╠═╣║ ║║ ║╠╩╗╚═╗
  //  ╚╩╝╚═╝╚═╝╩ ╩╚═╝╚═╝╩ ╩╚═╝


  //  ╔╦╗╦╔═╗╔═╗  ╦═╗╔═╗╔╦╗╦╦═╗╔═╗╔═╗╔╦╗╔═╗
  //  ║║║║╚═╗║    ╠╦╝║╣  ║║║╠╦╝║╣ ║   ║ ╚═╗
  //  ╩ ╩╩╚═╝╚═╝  ╩╚═╚═╝═╩╝╩╩╚═╚═╝╚═╝ ╩ ╚═╝
  '/terms':                   '/legal/terms',
  '/logout':                  '/api/v1/account/logout',

};
