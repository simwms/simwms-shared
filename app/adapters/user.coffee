`import Ember from 'ember'`
`import ActiveModelAdapter from 'active-model-adapter'`
`import ENV from '../config/environment'`

volatile = ->
  Ember.computed(arguments...).volatile()

UserAdapter = ActiveModelAdapter.extend
  host: ENV.host
  namespace: ENV.apiNamespace

`export default UserAdapter`