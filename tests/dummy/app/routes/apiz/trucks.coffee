`import Ember from 'ember'`

TrucksRoute = Ember.Route.extend
  beforeModel: ->
    @trucksChan.connect @currentUser.get("account")
  model: ->
    @store.findAll "onsite-truck"
  teardown: Ember.on "deactivate", ->
    @trucksChan.disconnect()

  actions:
    kill: (truck) ->
      truck.destroyRecord()

`export default TrucksRoute`