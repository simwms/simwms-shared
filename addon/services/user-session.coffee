`import Ember from 'ember'`

alias = Ember.computed.alias
ifPresent = Ember.computed.and
ifAny = Ember.computed.or
isBlank = Ember.isBlank
notEmpty = Ember.computed.notEmpty

Errors = Ember.Object.extend
  hasErrors: ifAny "hasEmailErrors", "hasTokenErrors"
  hasTokenErrors: notEmpty "token"
  hasEmailErrors: notEmpty "email"
  clear: ->
    @set "token", Ember.A()
    @set "email", Ember.A()
  addError: (key, msg) ->
    @getWithDefault(key, Ember.A()).pushObject msg

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
    @setError "email", "cannot be blank" if isBlank(@get "employeeEmail")
    @get "hasErrors"
  init: ->
    @_super arguments...
    @set "employeeEmail", Cookies.get("employeeEmail")
    @set "rememberToken", Cookies.get("rememberToken")
    @checkForErrors()
  configure: ({email, token}) ->
    @set("employeeEmail", email) if Ember.isPresent(email)
    @set("rememberToken", token) if Ember.isPresent(token)
    @checkForErrors()
  setup: (store) ->
    return @get("p") if @checkForErrors()

    Ember.RSVP.hash
      employee: store.find "employee", @get("employeeEmail")
      account: store.find "account", ""
      accountMeta: store.find "accountMetum", ""
    .then ({employee, account, accountMeta}) =>
      @set "employee", employee
      Cookies.set("employeeEmail", employee.get("email"))
      @set "account", account
      Cookies.set("rememberToken", @get("rememberToken"))
      @set "meta", accountMeta
      @
    .catch (errors) =>
      @setError "email", "Unrecognized employee email"
      @setError "token", "Unknown token"
      Cookies.remove "employeeEmail"
      Cookies.remove "rememberToken"
      @

  setError: (key, msg) ->
    @errors.addError key, msg

`export default UserSession`