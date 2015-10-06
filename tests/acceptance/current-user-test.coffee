`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import andAfterward from '../../tests/helpers/and-afterward'`
`import Fixtures from '../helpers/fixtures'`

module 'Acceptance: CurrentUser',
  beforeEach: ->
    Cookies.remove "employeeEmail"
    Cookies.remove "rememberToken"
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
    Cookies.remove "employeeEmail"
    Cookies.remove "rememberToken"

test 'properly working', (assert) ->
  visit '/'
  assert.ok @store, "the store should be in the index"
  assert.equal typeof @store.find, "function", "the store should be the DS store"
  assert.ok @currentUser, "currentUser should be injected into a route"
  assert.equal typeof @currentUser.configure, "function", "currentUser should be configurable"
  @currentUser.configure(Fixtures)

  andThen => 
    @currentUser.setup(@store)
    .then (session) ->
      assert.ok session, "session should be present"
      assert.ok session.get("isLoggedIn"), "we should be logged in"
      assert.ok session.get("permalink"), "we should have permalink"
      assert.ok session.get("employee"), "the employee model should be present"
      assert.equal session.get("employee.email"), Fixtures.email, "the proper email should be present"
      assert.ok session.get("account"), "the session should have the proper account"
      assert.equal session.get("account.email"), Fixtures.email, "email should match"
      assert.equal Cookies.get("employeeEmail"), Fixtures.email, "email should match"
      assert.equal Cookies.get("rememberToken"), Fixtures.token, "remember token should match"

      session.get("account.servicePlan")
    .then (servicePlan) ->
      assert.ok servicePlan, "the service plan should be there"
      assert.equal servicePlan.get("simwmsName"), "test", "it should be the correct plan"
      assert.equal servicePlan.get("docks"), Infinity
      assert.equal servicePlan.get("warehouses"), Infinity
      assert.equal servicePlan.get("employees"), Infinity
      assert.equal servicePlan.get("scales"), Infinity

test "screwing up blank", (assert) ->
  visit "/"
  @currentUser.configure({})
  assert.equal @currentUser.get("rememberToken"), null, "it should not have a token"
  assert.equal @currentUser.get("employeeEmail"), null, "it should not have an email"
  assert.equal @currentUser.get("hasErrors"), true, "it should have errors"
  andThen =>
    @currentUser.setup(@store)
    .then (session) ->
      assert.ok session.get("hasErrors"), "it should errors after trying to setup"
      errors = session.get("errors")
      assert.deepEqual errors.get("token"), ["cannot be blank"]
      assert.deepEqual errors.get("email"), ["cannot be blank"]

test "testing wrong email", (assert) ->
  visit "/"
  andThen =>
    @currentUser.configure
      token: "666hailsatan"
      email: "wrong email"
    @currentUser.setup(@store)
    .then (session) ->
      assert.ok session.get("hasErrors")
      errors = session.get('errors')
      assert.deepEqual errors.get("token"), ["Unknown token"]
      assert.deepEqual errors.get("email"), ["Unrecognized employee email"]