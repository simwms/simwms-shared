`import DS from 'ember-data'`
`import {LogCore} from 'simwms-shared'`

AppointmentLog = DS.Model.extend LogCore,
  appointment: DS.belongsTo "appointment", async: true

`export default AppointmentLog`