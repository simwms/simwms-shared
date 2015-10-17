`import Ember from 'ember'`

volatile = ->
  Ember.computed(arguments...).volatile()
  
SimwmsHeaders = Ember.Mixin.create
  headers: volatile "currentUser.simwmsUserSession", "currentUser.simwmsAccountSession", ->
    "simwms-user-session": @currentUser.get("simwmsUserSession")
    "simwms-account-session": @currentUser.get("simwmsAccountSession")

`export default SimwmsHeaders`