`import Ember from 'ember'`
`import FunctionalValidation from 'ember-functional-validation'`

blankPromise = new Ember.RSVP.Promise (resolve) -> resolve()

flf = (key) -> (meta) ->
  Ember.getWithDefault meta, "servicePlan", blankPromise
  .then (plan) -> plan?.get key

validateAccount = FunctionalValidation.create
  docks:
    lessThan: flf("docks")
  scales:
    lessThan: flf("scales")
  employees:
    lessThan: flf("employees")
  warehouses:
    lessThan: flf("warehouses")

`export default validateAccount`