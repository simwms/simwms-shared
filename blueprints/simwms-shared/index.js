module.exports = {
  description: 'installs js cookie, which is needed',
  afterInstall: function(options) {
    return this.addBowerPackagesToProject([{name: "js-cookie", target: "~2.0.3"}]);
  }
};
