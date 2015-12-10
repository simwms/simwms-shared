initialize = (application) ->
  application.inject "route", "appointmentsChan", "service:appointments-channel"
  application.inject "controller", "appointmentsChan", "service:appointments-channel"

AppointmentsChannelInitializer =
  name: 'appointments-channel'
  initialize: initialize

`export {initialize}`
`export default AppointmentsChannelInitializer`
