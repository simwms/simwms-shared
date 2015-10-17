`import DS from 'ember-data'`
`import ENV from '../config/environment'`

ServicePlanAdapter = DS.ActiveModelAdapter.extend
  host: ENV.host
  namespace: ENV.apiNamespace

`export default ServicePlanAdapter`