`import DS from 'ember-data'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders} from 'simwms-shared'`

AccountAdapter = DS.JSONAPIAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: ENV.apixNamespace 

`export default AccountAdapter`