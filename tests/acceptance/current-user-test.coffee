`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import Fixtures from '../helpers/fixtures'`

module 'Acceptance: CurrentUser',
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
      assert.ok session
      assert.ok session.get("isLoggedIn")
      assert.ok session.get("employee")
      assert.equal session.get("employee.email"), Fixtures.email
      assert.ok session.get("account")
      assert.equal session.get("account.email"), Fixtures.email
      assert.equal Cookies.get("employeeEmail"), Fixtures.email
      assert.equal Cookies.get("rememberToken"), Fixtures.token

test "screwing up blank", (assert) ->
  visit "/"
  @currentUser.configure({})
  andThen =>
    @currentUser.setup(@store)
    .then (session) ->
      assert.ok session.get("hasErrors")
      errors = session.get("errors")
      assert.deepEqual errors.get("token"), ["cannot be blank"]
      assert.deepEqual errors.get("email"), ["cannot be blank"]

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