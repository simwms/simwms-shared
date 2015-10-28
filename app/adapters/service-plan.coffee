`import ActiveModelAdapter from 'active-model-adapter'`
`import ENV from '../config/environment'`

ServicePlanAdapter = ActiveModelAdapter.extend
  host: ENV.host
  namespace: ENV.apiNamespace

`export default ServicePlanAdapter`