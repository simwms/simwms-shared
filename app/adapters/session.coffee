`import Ember from 'ember'`
`import ActiveModelAdapter from 'active-model-adapter'`
`import {SimwmsHeaders} from 'simwms-shared'`
`import ENV from '../config/environment'`

{computed} = Ember

SessionAdapter = ActiveModelAdapter.extend SimwmsHeaders,
  host: ENV.host
  apixNamespace: ENV.apixNamespace
  apiNamespace: ENV.apiNamespace
  
  urlForFindRecord: (id, modelName, snapshot) ->
    [@get("host"), @get("apixNamespace"), "session"].join("/")

  urlForCreateRecord: (modelName, snapshot) ->
    [@get("host"), @get("apiNamespace"), "sessions"].join("/")

  urlForDeleteRecord: (id, modelName, snapshot) ->
    [@get("host"), @get("apixNamespace"), "session"].join("/")
    
`export default SessionAdapter`