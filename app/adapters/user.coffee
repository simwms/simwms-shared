`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ENV from '../config/environment'`

volatile = ->
  Ember.computed(arguments...).volatile()

UserAdapter = DS.JSONAPIAdapter.extend
  host: ENV.host
  namespace: ENV.apiNamespace

`export default UserAdapter`