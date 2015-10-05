`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ENV from '../config/environment'`

volatile = ->
  Ember.computed(arguments...).volatile()

UserAdapter = DS.ActiveModelAdapter.extend
  host: ENV.host
  namespace: ENV.namespace
  headers: volatile "currentUser.rememberToken", ->
    "simwms-account-session": @get("currentUser.rememberToken")

`export default UserAdapter`