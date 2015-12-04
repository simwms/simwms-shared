initialize = (instance) ->
  instance.lookup("service:user-session").instanceInit()

UserSessionInitializer =
  name: 'user-session'
  initialize: initialize

`export {initialize}`
`export default UserSessionInitializer`
