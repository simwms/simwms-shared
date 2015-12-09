`import Ember from 'ember'`

AppointmentsRoute = Ember.Route.extend
  model: ->
    @store.findAll "appointment"

`export default AppointmentsRoute`