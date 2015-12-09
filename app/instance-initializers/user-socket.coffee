`import Phoenix from 'ember-phoenix-chan'`
`import ENV from '../config/environment'`
`import DS from 'ember-data'`

{Socket} = Phoenix
{socketNamespace} = ENV

initialize = (instance) ->
  instance.lookup("service:user-socket").instanceInit(Socket, socketNamespace)

UserSocketInitializer =
  name: 'user-socket'
  initialize: initialize

`export {initialize}`
`export default UserSocketInitializer`
