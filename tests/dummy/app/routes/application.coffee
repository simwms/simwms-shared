`import Ember from 'ember'`

AppRoute = Ember.Route.extend
  actions:
    autologin: ->
      @currentUser.login()
    logout: ->
      @currentUser.logout()
      .then =>
        @transitionTo "index"

`export default AppRoute`