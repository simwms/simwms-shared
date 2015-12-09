`import Ember from 'ember'`
`import ChanCore from '../mixins/chan-core'`
{Service, Evented} = Ember
{dashingularize} = ChanCore
AccountChannelService = Service.extend Evented, ChanCore,
  makeTopic: (account) -> 
    id = account.get("id")
    "accounts:#{id}"

  onDelta: Ember.on "delta", ({data}) ->
    data.type = dashingularize data.type
    @get("store").pushPayload data

  onNotify: Ember.on "notify", ({level, message}) ->
    level ?= "info"
    @get("notify")?[level]?message

`export default AccountChannelService`
