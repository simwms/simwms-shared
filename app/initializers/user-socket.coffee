initialize = (application) ->
  application.inject "service:user-socket", "currentUser", "service:user-session"
  application.inject "controller", "socket", "service:user-socket"
  application.inject "route", "socket", "service:user-socket"
  application.inject "controller", "socket", "service:user-socket"
  application.inject "adapter", "socket", "service:user-socket"

UserSocketInitializer =
  name: 'user-socket'
  after: 'user-session'
  initialize: initialize

`export {initialize}`
`export default UserSocketInitializer`
