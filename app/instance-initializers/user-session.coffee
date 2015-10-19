initialize = (instance) ->
  session = instance.container.lookup("service:user-session")
  session.smartLogin()

UserSessionInitializer =
  name: 'user-session'
  initialize: initialize

`export {initialize}`
`export default UserSessionInitializer`
