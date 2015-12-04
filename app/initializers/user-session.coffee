initialize = (application) ->
  application.inject "service:user-session", "store", "service:store"
  application.inject "controller", "currentUser", "service:user-session"
  application.inject "route", "currentUser", "service:user-session"
  application.inject "adapter", "currentUser", "service:user-session"

UserSessionInitializer =
  name: 'user-session'
  initialize: initialize

`export {initialize}`
`export default UserSessionInitializer`
