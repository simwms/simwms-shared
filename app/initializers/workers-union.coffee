# Takes two parameters: container and application
initialize = (application) ->
  application.inject "controller", "workersUnion", "service:workers-union"
  # application.register 'route', 'foo', 'service:foo'

WorkersUnionInitializer =
  name: 'workers-union'
  initialize: initialize

`export {initialize}`
`export default WorkersUnionInitializer`

