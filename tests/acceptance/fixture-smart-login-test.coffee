`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`

module 'Acceptance: FixtureSmartLogin',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @index = @application.__container__.lookup("route:index")
    @currentUser = @index.currentUser
    @store = @index.store
    return

  afterEach: ->
    Ember.run @application, 'destroy'

fixtures =
  userToken: "VBL43YFAMIPE7IHSUJ2ASD5XMEBLSZG5M4OSKW7Q54SSXNHICMDA===="
  accountToken: "6HKYAJCR7XKUGKR6HOHY42BN36GK3RBLG6VUP3YVQ7UZHTUNLIXA===="

test 'visiting /fixture-smart-login', (assert) ->
  visit '/'

  andThen =>
    @currentUser.smartLogin fixtures
    .then =>
      assert.ok @currentUser.get("isLoggedIn"), "we should be logged into the user"
      assert.ok @currentUser.get("accountLoggedIn"), "we should login onto the fixture account"
      meta = @currentUser.get("meta")
      assert.notEqual null, false, "what"
      assert.equal meta.get("requiresUpgrade"), false, "upgrade requirement should work"
    .finally =>
      @currentUser.logout()
