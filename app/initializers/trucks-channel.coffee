initialize = (application) ->
  application.inject "route", "trucksChan", "service:trucks-channel"
  application.inject "controller", "trucksChan", "service:trucks-channel"

TrucksChannelInitializer =
  name: 'trucks-channel'
  after: 'user-socket'
  initialize: initialize

`export {initialize}`
`export default TrucksChannelInitializer`
