`import Ember from 'ember'`

AccountsRoute = Ember.Route.extend
  model: ->
    @store.findAll "account"
  actions:
    activate: (account) ->
      @currentUser.accountLogin account

`export default AccountsRoute`