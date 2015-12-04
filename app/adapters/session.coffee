`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {SimwmsHeaders} from 'simwms-shared'`
`import ENV from '../config/environment'`

SessionAdapter = DS.JSONAPIAdapter.extend SimwmsHeaders,
  host: ENV.host
  apixNamespace: ENV.apixNamespace
  apiNamespace: ENV.apiNamespace

  urlForCreateRecord: (modelName, snapshot) ->
    [@get("host"), @get("apiNamespace"), "sessions"].join("/")

  urlForDeleteRecord: (id, modelName, snapshot) ->
    [@get("host"), @get("apixNamespace"), "sessions", encodeURIComponent(id)].join("/")
    
`export default SessionAdapter`