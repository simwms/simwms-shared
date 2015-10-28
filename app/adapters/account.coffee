`import Ember from 'ember'`
`import ActiveModelAdapter from 'active-model-adapter'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders} from 'simwms-shared'`

AccountAdapter = ActiveModelAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: ENV.apixNamespace 

`export default AccountAdapter`