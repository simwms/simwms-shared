`import Ember from 'ember'`

ApizRoute = Ember.Route.extend
  model: ->
    @currentUser.smartLogin()
  afterModel: ->
    unless @currentUser.get("accountLoggedIn")
      @transitionTo "index"

`export default ApizRoute`