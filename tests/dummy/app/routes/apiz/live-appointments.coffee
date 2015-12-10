`import Ember from 'ember'`

LiveAppointmentsRoute = Ember.Route.extend
  beforeModel: ->
    @appointmentsChan.connect @currentUser.get("account")
  model: ->
    @store.findAll "live-appointment"
  teardown: Ember.on "deactivate", ->
    @appointmentsChan.disconnect()

  actions:
    kill: (appt) ->
      appt.destroyRecord()

`export default LiveAppointmentsRoute`