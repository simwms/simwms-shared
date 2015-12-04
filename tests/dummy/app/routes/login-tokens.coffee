`import Ember from 'ember'`

LoginTokensRoute = Ember.Route.extend
  model: ->
    @currentUser

  actions:
    submit: ->
      @currentUser.smartLogin()

`export default LoginTokensRoute`