`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ENV from '../config/environment'`

alias = Ember.computed.alias

Account = DS.Model.extend
  permalink: DS.attr "string"
  username: DS.attr "string"
  email: DS.attr "string"
  companyName: DS.attr "string"
  accessKeyId: DS.attr "string"
  secretAccessKey: DS.attr "string"
  timezone: DS.attr "string"
  namespace: DS.attr "string"
  host: DS.attr "string"
  roxieKey: DS.attr "string"
  uiuxHost: DS.attr "string", defaultValue: ENV.uiuxHost
  configHost: DS.attr "string", defaultValue: ENV.configHost
  insertedAt: DS.attr "date"
  status: DS.attr "string", defaultValue: "ok"
  region: alias "timezone"
  servicePlan: DS.belongsTo "servicePlan", async: true
  isProperlySetup: DS.attr "boolean"
  simwmsAccountKey: DS.attr "string"

`export default Account`