`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {SimwmsHeaders} from 'simwms-shared'`
`import ENV from '../config/environment'`

{computed} = Ember

SessionAdapter = DS.ActiveModelAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: computed "currentUser.state", 
    get: -> 
      switch @get "currentUser.state"
        when "uncertain" then ENV.apixNamespace
        when "login-success" then ENV.apixNamespace
        when "login-failed" then ENV.apiNamespace
        when "logout-success" then ENV.apiNamespace
        else throw "Unknown state: #{@get "currentUser.state"}"
  

`export default SessionAdapter`