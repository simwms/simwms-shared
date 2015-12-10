`import Ember from 'ember'`
`import DS from 'ember-data'`
`import ENV from '../config/environment'`

{isPresent, isBlank, $, computed} = Ember
{printHost, printNamespace} = ENV

Report = DS.Model.extend
  accountId: DS.attr "string"
  startAt: DS.attr "moment"
  finishAt: DS.attr "moment"
  link: computed "id", "accountId", "startAt", "finishAt",
    get: ->
      return if isBlank @get "id"
      query =
        account_id: @get("accountId")
        start_at: @get("startAt")
        finish_at: @get("finishAt")
      url = [printHost, printNamespace, "reports", @get("id")]
      .filter isPresent
      .join("/")
      "#{url}?#{$.param query}"

`export default Report`