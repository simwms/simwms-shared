`import Ember from 'ember'`
`import DS from 'ember-data'`
`import {Money} from 'simwms-shared'`
c = Ember.computed

ServicePlan = DS.Model.extend
  account: DS.belongsTo "account", async: false
  simwmsName: DS.attr "string"
  permalink: DS.attr "string"
  version: DS.attr "string"
  presentation: DS.attr "string"
  description: DS.attr "string"
  monthlyPrice: DS.attr "number", defaultValue: 0
  docks: DS.attr "number", defaultValue: Infinity
  scales: DS.attr "number", defaultValue: Infinity
  warehouses: DS.attr "number", defaultValue: Infinity
  employees: DS.attr "number", defaultValue: Infinity
  availability: DS.attr "number", defaultValue: 24
  appointments: DS.attr "number", defaultValue: Infinity
  deprecatedAt: DS.attr "moment"

  pricePresentation: c "monthlyPrice", ->
    $p = Money.fromCents @get("monthlyPrice")
    if $p > 0 then "$#{$p} / month" else "free"

  isDeprecated: c.and "deprecatedAt"
  isAvailable: c "deprecatedAt", ->
    if @get("deprecatedAt")?
      false
    else
      true
  
`export default ServicePlan`