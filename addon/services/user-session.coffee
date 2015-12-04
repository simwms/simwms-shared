`import Ember from 'ember'`

{computed, Service, RSVP, isBlank, get, isPresent, Evented} = Ember
{alias, notEmpty, equal, and: present, or: ifAny} = computed

UserSession = Service.extend Evented,
  rank: alias "employee.role"
  accountLoggedIn: present "account.permalink"
  namespace: alias "account.namespace"
  permalink: alias "account.permalink"
  host: alias "account.host"

  state: alias "session.state"
  username: alias "session.username"
  email: alias "session.email"
  password: alias "session.password"
  errors: alias "session.errors"
  accountToken: alias "simwmsAccountSession"
  rememberToken: alias "session.rememberToken"
  simwmsAccountSession: alias "session.simwmsAccountSession"
  simwmsUserSession: alias "session.simwmsUserSession"
  
  isLoggedIn: equal "state", "login-success"
  hasErrors: alias "session.isError"
  p: computed -> RSVP.Promise.resolve @

  instanceInit: ->
    @set "session", @store.createRecord("session").firstSetup()

  logout: ->
    return @get("p") if isBlank @get "session"
    @accountLogout()
    @get("session")
    .destroyRecord()
    .then =>
      @trigger "logout-user"
    .finally @instanceInit.bind(@)
  login: ->
    return @get("p") if @get "isLoggedIn"
    @get "session"
    .save()
    .then =>
      @trigger "login-user"
  setFrom: (key, obj={}) ->
    if (v = get obj, key)?
      @set key, v
  smartLogin: (params) ->
    if params?
      @setFrom "email", params
      @setFrom "password", params
      @setFrom "accountToken", params
      @setFrom "rememberToken", params
    @login()
    .then => @accountLogin()
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
      @

`export default UserSession`