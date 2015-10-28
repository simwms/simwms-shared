`import Ember from 'ember'`

AppRoute = Ember.Route.extend
  model: ->
    @currentUser.cookieLogin()

`export default AppRoute`