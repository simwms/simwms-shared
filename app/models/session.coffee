`import Ember from 'ember'`
`import DS from 'ember-data'`

{computed, String} = Ember
{alias} = computed
volatile = ->
  computed(arguments...).volatile()

cookieSetter = (key, value) -> 
  if value? 
    Cookies.set(String.dasherize(key), value, expires: 365) 
  else
    Cookies.remove String.dasherize key

Session = DS.Model.extend
  email: DS.attr "string"
  password: DS.attr "string"
  username: DS.attr "string"
  rememberToken: DS.attr "string"

  user: DS.belongsTo "user", async: true

  state: "uncertain"

  accountToken: alias "simwmsAccountSession" 
  simwmsAccountSession: volatile
    set: cookieSetter
    get: -> Cookies.get("simwms-account-session")

  simwmsUserSession: volatile
    set: cookieSetter
    get: -> Cookies.get("simwms-user-session")

  firstSetup: ->
    @set "rememberToken", @get "simwmsUserSession"
    @

  becameError: ->
    @set "state", "login-failed"

  didLoad: ->
    @set "state", "login-success"

  didCreate: ->
    @set "state", "login-success"
    @set "simwmsUserSession", @get "rememberToken"

  didDelete: ->
    @set "state", "logout-success"
    @set "simwmsUserSession", null

`export default Session`