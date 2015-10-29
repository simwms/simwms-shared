`import Ember from 'ember'`
`import Errors from '../utils/errors'`

{computed} = Ember
{alias, notEmpty, equal} = computed
ifPresent = computed.and
ifAny = computed.or
isBlank = Ember.isBlank

volatile = ->
  Ember.computed(arguments...).volatile()

cookieSetter = (key, value) -> 
  if value? then Cookies.set(key, value) else Cookies.remove(key)

SessionStates = ["uncertain", "login-success", "login-failed", "logout-success"]
UserSession = Ember.Service.extend
  state: "uncertain"
  rank: alias "employee.role"
  isLoggedIn: equal "state", "login-success"
  accountLoggedIn: ifPresent "account.permalink"
  username: alias "session.username"
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
    @accountLogout()
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
      @errors.addErrors errors
      @set "simwmsUserSession", null
      @set "state", "login-failed"
    .finally => @
  cookieLogin: (userToken) ->
    return @get("p") if @get "isLoggedIn"
    if Ember.isPresent userToken
      @set "simwmsUserSession", userToken 
    @store.find "session", "cookie-session"
    .then (session) =>
      @set "session", session
      @set "state", "login-success"
    .catch (errors) =>
      @set "simwmsUserSession", null
      @set "state", "login-failed"
    .finally => @
  smartLogin: ({email, accountToken, password, userToken}={}) ->
    @cookieLogin(userToken)
    .then =>
      @login({email, password})
    .then =>
      @accountLogin accountToken
    .finally => @
  accountLogout: ->
    @set "simwmsAccountSession", null
    @set "meta", null
    @set "account", null
    @set "servicePlan", null
    @set "employee", null
    @set "paymentSubscription", null
    @
  accountLogin: (account) ->
    return @get("p") unless @get "isLoggedIn"
    return @get("p") if @get "accountLoggedIn"
    accountToken = switch
      when typeof account is "string" then account
      when isBlank(account) then @get("simwmsAccountSession")
      when typeof account.get is "function" then account.get("permalink")
      else throw new "I don't know how to handle #{account}"
    return @get("p") if Ember.isBlank(accountToken)
    @store.find "account-detail", accountToken
    .then (detail) =>
      @set "simwmsAccountSession", accountToken
      @set "meta", detail
      Ember.RSVP.hash
        account: detail.get("account")
        plan: detail.get("servicePlan")
        employee: detail.get("employee")
    .then ({account, plan, employee, sub}) =>
      @set "account", account
      @set "servicePlan", plan
      @set "employee", employee
    .catch (errors) =>
      @errors.addError 
        key: "token"
        msg: "bad token"
      @set "simwmsAccountSession", null
    .finally => @

  clearErrors: ->
    @errors.clear()

  checkForErrors: ({email, password})->
    if isBlank(email)
      @errors.addError
        key: "email"
        msg: "cannot be blank"
    if isBlank(password)
      @errors.addError 
        key: "password"
        msg: "cannot be blank"
    @get "hasErrors"

`export default UserSession`