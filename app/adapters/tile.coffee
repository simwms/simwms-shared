`import DS from 'ember-data'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders} from 'simwms-shared'`

TileAdapter = DS.JSONAPIAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: ENV.apizNamespace

  urlForCreateRecord: (modelName, snapshot) ->
    [@get("host"), ENV.apiaNamespace, "tiles"].join("/")

  urlForDeleteRecord: (id, modelName, snapshot) ->
    [@get("host"), ENV.apiaNamespace, "tiles", encodeURIComponent(id)].join("/")

`export default TileAdapter`