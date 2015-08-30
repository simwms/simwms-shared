module.exports = {
  description: 'installs js cookie, which is needed'

  // locals: function(options) {
  //   // Return custom template variables here.
  //   return {
  //     foo: options.entity.options.foo
  //   };
  // }

  afterInstall: function(options) {
    return this.addBowerPackagesToProject([{name: "js-cookie", target: "~2.0.3"}]);
  }
};
