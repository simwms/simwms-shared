`import DS from 'ember-data'`
`import ENV from '../config/environment'`
`import {SimwmsHeaders} from 'simwms-shared'`

{computed} = Ember

EmployeeAdapter = DS.JSONAPIAdapter.extend SimwmsHeaders,
  host: ENV.host
  namespace: computed "currentUser.rank",
    get: ->
      switch @currentUser.get("rank")
        when "admin_manager", "admin", "manager" then ENV.apiaNamespace
        when "scalemaster","dockworker","logistics","inventory","none" then ENV.apizNamespace
        else ENV.apixNamespace

`export default EmployeeAdapter`