`import Ember from 'ember'`
`import AccountChan from './account-channel'`

UserChannelService = AccountChan.extend
  makeTopic: (session) -> 
    id = session.get("id")
    "users:#{id}"

`export default UserChannelService`
