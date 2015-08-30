`import Ember from 'ember'`
`import DS from 'ember-data'`

c = Ember.computed

ServicePlan = DS.Model.extend
  permalink: DS.attr "string"
  version: DS.attr "string"
  presentation: DS.attr "string"
  description: DS.attr "string"
  monthlyPrice: DS.attr "number", defaultValue: 0
  docks: DS.attr "number", defaultValue: Infinity
  scales: DS.attr "number", defaultValue: Infinity
  warehouses: DS.attr "number", defaultValue: Infinity
  users: DS.attr "number", defaultValue: Infinity
  availability: DS.attr "number", defaultValue: 24
  appointments: DS.attr "number", defaultValue: Infinity
  deprecatedAt: DS.attr "date"

  pricePresentation: c "monthlyPrice", ->
    $p = @get("monthlyPrice")
    if $p > 0 then "$#{$p} / month" else "free"

  isDeprecated: c.and "deprecatedAt"
  isAvailable: c "deprecatedAt", ->
    if @get("deprecatedAt")?
      false
    else
      true
  
`export default ServicePlan`