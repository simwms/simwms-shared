`import Ember from 'ember'`
`import ChanCore from '../mixins/chan-core'`
{Service, Evented} = Ember
{dashingularize} = ChanCore

AppointmentsChannelService = Service.extend Evented, ChanCore,
  makeTopic: (account) -> 
    id = account.get("id")
    "live_appointments:accounts:#{id}"

  onUpdate: Ember.on "update", (payload) ->
    payload.type = dashingularize payload.type
    @get("store").pushPayload payload

  onDestroy: Ember.on "destroy", (payload) ->
    {type, id} = payload
    type = if type? then dashingularize(type) else "live-appointment"
    if (record = @get("store").peekRecord type, id)?
      @get("store").unloadRecord record

`export default AppointmentsChannelService`