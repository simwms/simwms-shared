`import Ember from 'ember'`

volatile = ->
  Ember.computed(arguments...).volatile()
  
SimwmsHeaders = Ember.Mixin.create
  headers: volatile "currentUser.rememberToken", "currentUser.accountToken", ->
    "simwms-user-session": @currentUser.get("rememberToken")
    "simwms-account-session": @currentUser.get("accountToken")

`export default SimwmsHeaders`