/* jshint node: true */
'use strict';

module.exports = {
  name: 'simwms-shared',
  included: function(app) {
    this._super.included(app);
    this.app.import(app.bowerDirectory + "/js-cookie/src/js.cookie.js");
  }
};
