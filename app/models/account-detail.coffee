`import DS from 'ember-data'`
`import Ember from 'ember'`
`import {validateAccount} from 'simwms-shared'`

{computed: {alias}} = Ember

AccountDetail = DS.Model.extend
  docks: DS.attr "number", defaultValue: Infinity
  warehouses: DS.attr "number", defaultValue: Infinity
  employees: DS.attr "number", defaultValue: Infinity
  scales: DS.attr "number", defaultValue: Infinity
  servicePlan: DS.belongsTo "service-plan", async: true
  account: DS.belongsTo "account", async: true
  employee: DS.belongsTo "employee", async: true
  paymentSubscription: DS.belongsTo "payment-subscription", async: true

  cells: alias "warehouses"

  calculateUpgradeRequirement: Ember.on "ready", ->
    @set "validationErrors", null
    validateAccount @
    .then => 
      @set "requiresUpgrade", false
    .catch (errors) => 
      @set "validationErrors", errors
      @set "requiresUpgrade", true

`export default AccountDetail`