`import DS from 'ember-data'`

AccountDetail = DS.Model.extend
  docks: DS.attr "number", defaultValue: Infinity
  warehouses: DS.attr "number", defaultValue: Infinity
  employees: DS.attr "number", defaultValue: Infinity
  scales: DS.attr "number", defaultValue: Infinity
  servicePlan: DS.belongsTo "service-plan", async: true
  account: DS.belongsTo "account", async: true
  employee: DS.belongsTo "employee", async: true
  paymentSubscription: DS.belongsTo "payment-subscription", async: true

`export default AccountDetail`