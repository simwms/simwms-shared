`import DS from 'ember-data'`

AccountMetum = DS.Model.extend
  docks: DS.attr "number", defaultValue: Infinity
  warehouses: DS.attr "number", defaultValue: Infinity
  employees: DS.attr "number", defaultValue: Infinity
  scales: DS.attr "number", defaultValue: Infinity
  servicePlan: DS.belongsTo "servicePlan", async: true

`export default AccountMetum`