`import DS from 'ember-data'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders, Singleton} from 'simwms-shared'`

PaymentSubscriptionAdapter = DS.JSONAPIAdapter.extend SimwmsHeaders, Singleton,
  host: ENV.host
  namespace: ENV.apiaNamespace

`export default PaymentSubscriptionAdapter`