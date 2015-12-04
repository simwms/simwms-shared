`import Ember from 'ember'`

ApixRoute = Ember.Route.extend
  model: ->
    @currentUser.login()
  afterModel: ->
    unless @currentUser.get("isLoggedIn")
      @transitionTo "index"

`export default ApixRoute`