`import Ember from 'ember'`
`import FunctionalValidation from 'ember-functional-validation'`

blankPromise = new Ember.RSVP.Promise (resolve) -> resolve()

flf = (key) -> (meta) ->
  Ember.getWithDefault meta, "servicePlan", blankPromise
  .then (plan) -> plan?.get key

validateAccount = FunctionalValidation.create
  docks:
    lessThanEqualTo: flf("docks")
  scales:
    lessThanEqualTo: flf("scales")
  employees:
    lessThanEqualTo: flf("employees")
  warehouses:
    lessThanEqualTo: flf("warehouses")

`export default validateAccount`