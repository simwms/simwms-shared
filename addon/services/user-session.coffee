`import Ember from 'ember'`

alias = Ember.computed.alias
ifPresent = Ember.computed.and
ifAny = Ember.computed.or
isBlank = Ember.isBlank
notEmpty = Ember.computed.notEmpty

Errors = Ember.Object.extend
  hasErrors: ifAny "hasAccountErrors", "hasTokenErrors"
  hasAccountErrors: notEmpty "account"
  hasTokenErrors: notEmpty "token"
  clear: ->
    @set "account", []
    @set "token", []
  addError: (key, msg) ->
    @getWithDefault(key, []).pushObject msg

UserSession = Ember.Service.extend
  isLoggedIn: ifPresent "account.id"
  namespace: alias "account.namespace"
  host: alias "account.host"
  simwmsAccountSession: alias "rememberToken"
  hasErrors: alias "errors.hasErrors"
  errors: Errors.create()
  p: Ember.computed -> new Ember.RSVP.Promise (r) => r @
  checkForErrors: ->
    @errors.clear()
    @setError "token", "cannot be blank" if isBlank(@get "rememberToken")
    @get "hasErrors"
  configure: ({token}) ->
    @set "accountId", "singleton"
    @set "rememberToken", (token ? Cookies.get("rememberToken"))
  setup: (store) ->
    return @get("p") if @checkForErrors()

    store.find "account", "singleton"
    .then (account) =>
      @set "account", account
      Cookies.set("rememberToken", @get("rememberToken"))
      @
    .catch ({errors}) =>
      @setError "token", "Unknown token"
      Cookies.remove "rememberToken"
      @

  setError: (key, msg) ->
    @errors.addError key, msg

`export default UserSession`