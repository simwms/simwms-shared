`import DS from 'ember-data'`

User = DS.Model.extend
  account: DS.belongsTo "account", async: true
  employee: DS.belongsTo "employee", async: true

`export default User`