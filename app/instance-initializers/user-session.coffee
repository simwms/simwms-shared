initialize = (instance) ->
  session = instance.container.lookup("service:user-session")
  session.cookieLogin()

UserSessionInitializer =
  name: 'user-session'
  initialize: initialize

`export {initialize}`
`export default UserSessionInitializer`
