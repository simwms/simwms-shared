`import DS from 'ember-data'`
`import ENV from '../config/environment'`

ServicePlanAdapter = DS.JSONAPIAdapter.extend
  host: ENV.host
  namespace: ENV.apiNamespace

`export default ServicePlanAdapter`