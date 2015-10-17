`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders} from 'simwms-shared'`

AccountAdapter = DS.ActiveModelAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: ENV.apixNamespace 

`export default AccountAdapter`