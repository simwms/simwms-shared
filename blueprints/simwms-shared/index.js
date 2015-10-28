var RSVP = require('rsvp');

module.exports = {
  description: 'installs js cookie, which is needed',
  afterInstall: function(options) {
    return RSVP.all([
      this.addBowerPackagesToProject([{name: "js-cookie", target: "~2.0.3"}]),
      this.addPackageToProject("active-model-adapter", "1.13.6")
    ]);
  }
};
