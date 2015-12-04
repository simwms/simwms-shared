`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import Fixtures from '../../tests/helpers/fixtures'`

module 'Acceptance: Login',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @index = @application.__container__.lookup("route:index")
    @currentUser = @index.currentUser
    @store = @index.store
    Cookies.remove "simwms-user-session"
    return

  afterEach: ->
    Cookies.remove "simwms-user-session"
    Ember.run @application, 'destroy'


test 'visiting /login', (assert) ->
  visit '/login'

  andThen =>
    assert.equal currentPath(), "login", "we should be at the right path"
    fillIn "[name=email]", Fixtures.email
    fillIn "[name=password]", Fixtures.password
    click "[type=submit]"

  andThen =>
    assert.ok @currentUser.get("isLoggedIn"), "we should be logged in after this"
    assert.notOk @currentUser.get("accountLoggedIn"), "we should have no account logged in"
    assert.ok find("#logout-btn"), "the logout button should be there"
    assert.ok @currentUser.get("rememberToken"), "we should have a remember token"
    assert.equal Cookies.get("simwms-user-session"), @currentUser.get("rememberToken"), "the tokens should match"
    click "#logout-btn"

  andThen ->
    visit '/login'

  andThen =>
    assert.notOk @currentUser.get("isLoggedIn"), "we should be logged out after this"
    fillIn "[name=email]", Fixtures.email
    fillIn "[name=password]", Fixtures.password
    click "[type=submit]"

  andThen =>
    assert.ok @currentUser.get("isLoggedIn"), "we should be logged in"
    assert.ok find("#logout-btn"), "the logout button should be there"
    click "#logout-btn"