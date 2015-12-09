`import Ember from 'ember'`
`import ChanCore from '../mixins/chan-core'`
{Service, Evented} = Ember
{dashingularize} = ChanCore

TrucksChannelService = Service.extend Evented, ChanCore,
  makeTopic: (account) -> 
    id = account.get("id")
    "onsite_trucks:accounts:#{id}"

  onUpdate: Ember.on "update", (payload) ->
    payload.type = dashingularize payload.type
    @get("store").pushPayload payload

  onDestroy: Ember.on "destroy", (payload) ->
    {type, id} = payload
    type = if type? then dashingularize(type) else "onsite-truck"
    if (record = @get("store").peekRecord type, id)?
      @get("store").unloadRecord record

`export default TrucksChannelService`