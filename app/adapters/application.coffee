`import DS from 'ember-data'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders} from 'simwms-shared'`

ApplicationAdapter = DS.JSONAPIAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: ENV.apizNamespace 

`export default ApplicationAdapter`