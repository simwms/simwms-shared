`import Ember from 'ember'`
`import Errors from '../utils/errors'`

{computed, Service, RSVP, isBlank, String, isPresent, Evented} = Ember
{alias, notEmpty, equal, and: present, or: ifAny} = computed

volatile = ->
  computed(arguments...).volatile()

cookieSetter = (key, value) -> 
  if value? 
    Cookies.set(String.dasherize(key), value, expires: 365) 
    Cookies.set(key, value, expires: 365) 
  else
    Cookies.remove String.dasherize key
    Cookies.remove key

SessionStates = ["uncertain", "login-success", "login-failed", "logout-success"]
UserSession = Service.extend Evented,
  state: "uncertain"
  rank: alias "employee.role"
  isLoggedIn: equal "state", "login-success"
  accountLoggedIn: present "account.permalink"
  username: alias "session.username"
  namespace: alias "account.namespace"
  permalink: alias "account.permalink"
  host: alias "account.host"
  hasErrors: alias "errors.hasErrors"
  errors: Errors.create()
  p: computed -> RSVP.Promise.resolve @
  simwmsAccountSession: volatile
    set: cookieSetter
    get: ->
      Cookies.get("simwmsAccountSession")

  simwmsUserSession: volatile
    set: cookieSetter
    get: ->
      Cookies.get("simwmsUserSession")
  
  logout: ->
    return @get("p") if isBlank @get "session"
    @accountLogout()
    @get("session")
    .destroyRecord()
    .then =>
      @set "simwmsUserSession", null
      @set "state", "logout-success"
      @set "session", null
      @trigger "logout-user"
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
      @trigger "login-user"
    .catch (errors) =>
      @errors.addErrors errors
      @set "simwmsUserSession", null
      @set "state", "login-failed"
    .finally => @
  cookieLogin: (userToken) ->
    return @get("p") if @get "isLoggedIn"
    if isPresent userToken
      @set "simwmsUserSession", userToken 
    @store.find "session", "cookie-session"
    .then (session) =>
      @set "session", session
      @set "state", "login-success"
      @trigger "login-user"
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
    @trigger "logout-account"
    @
  accountLogin: (account) ->
    return @get("p") unless @get "isLoggedIn"
    return @get("p") if @get "accountLoggedIn"
    accountToken = switch
      when typeof account is "string" then account
      when isBlank(account) then @get("simwmsAccountSession")
      when typeof account.get is "function" then account.get("permalink")
      else throw new "I don't know how to handle #{account}"
    return @get("p") if isBlank(accountToken)
    @store.find "account-detail", accountToken
    .then (detail) =>
      @set "simwmsAccountSession", accountToken
      @set "meta", detail
      RSVP.hash
        account: detail.get("account")
        plan: detail.get("servicePlan")
        employee: detail.get("employee")
        sub: detail.get("paymentSubscription")
    .then ({account, plan, employee, sub}) =>
      @set "account", account
      @set "servicePlan", plan
      @set "employee", employee
      @set "paymentSubscription", sub
      @trigger "login-account"
    .catch (errors) =>
      {errors: es} = errors
      throw errors if isBlank es
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