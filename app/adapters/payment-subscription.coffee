`import ActiveModelAdapter from 'active-model-adapter'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders, Singleton} from 'simwms-shared'`

PaymentSubscriptionAdapter = ActiveModelAdapter.extend SimwmsHeaders, Singleton,
  host: ENV.host
  namespace: ENV.apiaNamespace

`export default PaymentSubscriptionAdapter`