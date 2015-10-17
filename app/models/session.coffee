`import DS from 'ember-data'`

Session = DS.Model.extend
  email: DS.attr "string"
  password: DS.attr "string"
  username: DS.attr "string"
  rememberToken: DS.attr "string"
  
  user: DS.belongsTo "user", async: true

`export default Session`