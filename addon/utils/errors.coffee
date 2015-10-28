`import Ember from 'ember'`
`import {simplifyError} from './apiv3-error-tools'`

{computed, A} = Ember
{notEmpty: notEmpty, or: ifAny} = computed

Errors = Ember.Object.extend
  hasErrors: ifAny "hasEmailErrors", "hasTokenErrors", "hasPasswordErrors", "hasSystemErrors"
  hasTokenErrors: notEmpty "token"
  hasPasswordErrors: notEmpty "password"
  hasEmailErrors: notEmpty "email"
  hasSystemErrors: notEmpty "system"
  core: computed "password", "email", "token", "system",
    get: ->
      password: @get("password")
      email: @get("email")
      token: @get("token")
      system: @get("system")
  
  init: ->
    @_super arguments...
    @clear()

  clear: ->
    @set "password", A()
    @set "email", A()
    @set "token", A()
    @set "system", A()
  
  addError: ({key, msg}) ->
    switch key
      when "email", "password", "token", "system"
        @get(key).pushObject msg
      else
        @addError "system", msg

  addErrors: ({errors}) ->
    A errors
    .map simplifyError
    .forEach @addError, @

`export default Errors`