`import DS from 'ember-data'`

User = DS.Model.extend
  email: DS.attr "string"
  username: DS.attr "string"
  password: DS.attr "string"

`export default User`