`import Ember from 'ember'`

{computed} = Ember
{alias, notEmpty, equal} = computed
ifPresent = computed.and
ifAny = computed.or
isBlank = Ember.isBlank

volatile = ->
  Ember.computed(arguments...).volatile()

Errors = Ember.Object.extend
  hasErrors: ifAny "hasEmailErrors", "hasTokenErrors"
  hasTokenErrors: notEmpty "password"
  hasEmailErrors: notEmpty "email"
  clear: ->
    @set "password", Ember.A()
    @set "email", Ember.A()
  addError: (key, msg) ->
    @getWithDefault(key, Ember.A()).pushObject msg

cookieSetter = (key, value) -> 
  if value? then Cookies.set(key, value) else Cookies.remove(key)

SessionStates = ["uncertain", "login-success", "login-failed", "logout-success"]
UserSession = Ember.Service.extend
  state: "uncertain"
  rank: alias "employee.role"
  isLoggedIn: equal "state", "login-success"
  accountLoggedIn: ifPresent "account.permalink"
  namespace: alias "account.namespace"
  permalink: alias "account.permalink"
  host: alias "account.host"
  hasErrors: alias "errors.hasErrors"
  errors: Errors.create()
  p: Ember.computed -> new Ember.RSVP.Promise (r) => r @
  simwmsAccountSession: volatile
    set: cookieSetter
    get: ->
      Cookies.get("simwmsAccountSession")

  simwmsUserSession: volatile
    set: cookieSetter
    get: ->
      Cookies.get("simwmsUserSession")
  
  logout: ->
    return @get("p") if Ember.isBlank @get "session"
    @get("session")
    .destroyRecord()
    .then => 
      @set "simwmsUserSession", null
      @set "state", "logout-success"
      @set "session", null
    .finally => @
  login: ({email, password}) ->
    return @get("p") if @get "isLoggedIn"
    return @get("p") if @checkForErrors({email, password})
    @store.createRecord "session", {email, password}
    .save()
    .then (session) =>
      @set "session", session
      @set "simwmsUserSession", session.get("rememberToken")
      @set "state", "login-success"
    .catch (errors) =>
      @setErrors errors
      @set "simwmsUserSession", null
      @set "state", "login-failed"
    .finally => @
  cookieLogin: ->
    @store.find "session", "cookie-session"
    .then (session) =>
      @set "session", session
      @set "state", "login-success"
    .catch =>
      @set "simwmsUserSession", null
      @set "state", "login-failed"
    .finally => @
  smartLogin: ({email, accountToken, password}) ->
    @login({email, password})
    .then (session) =>
      if accountToken?
        @accountLogin accountToken
      else
        session
    .finally => @
  accountLogout: ->
    @set "simwmsAccountSession", null
    @set "meta", null
    @set "account", null
    @set "servicePlan", null
    @set "employee", null
    @
  accountLogin: (account) ->
    return @get("p") unless @get "isLoggedIn"
    return @get("p") if @get "accountLoggedIn"
    accountToken = switch
      when typeof account is "string" then account
      when Ember.isBlank(account) then @get("simwmsAccountSession")
      when typeof account.get is "function" then account.get("permalink")
      else throw new "I don't know how to handle #{account}"
    @store.find "account-detail", accountToken
    .then (detail) =>
      @set "simwmsAccountSession", accountToken
      @set "meta", detail
      Ember.RSVP.hash
        account: detail.get("account")
        plan: detail.get("servicePlan")
        employee: detail.get("employee")
    .then ({account, plan, employee}) =>
      @set "account", account
      @set "servicePlan", plan
      @set "employee", employee
    .catch (errors) ->
      @set "simwmsAccountSession", null
    .finally => @

  setError: (key, msg) ->
    @errors.addError key, msg

  setErrors: (email: emailErr, password: passErr) ->
    @errors.clear()
    @errors.addError "email", emailErr if Ember.isPresent(emailErr)
    @errors.addError "password", passErr if Ember.isPresent(passErr)

  checkForErrors: ({email, password})->
    @errors.clear()
    @setError "email", "cannot be blank" if isBlank(email)
    @setError "password", "cannot be blank" if isBlank(password)
    @get "hasErrors"

`export default UserSession`