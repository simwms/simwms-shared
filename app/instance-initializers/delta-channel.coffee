`import Ember from 'ember'`

{inject} = Ember

initialize = (instance) ->
  currentUser = instance.lookup "service:user-session"

  currentUser.notify = inject.service "notify"
  currentUser.userChan = inject.service "user-channel"
  currentUser.accountChan = inject.service "account-channel"
  
  currentUser.on "logout-user", ->
    @get("userChan").disconnect()

  currentUser.on "login-user", ->
    @get("userChan").connect @get "session"

  currentUser.on "logout-account", ->
    @get("accountChan").disconnect()

  currentUser.on "login-account", ->
    @get("accountChan").connect @get "account"

DeltaChanInitializer =
  name: 'delta-channel'
  initialize: initialize

`export {initialize}`
`export default DeltaChanInitializer`
