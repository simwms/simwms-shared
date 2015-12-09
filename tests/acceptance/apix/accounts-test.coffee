`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import Fixtures from '../../tests/helpers/fixtures'`

module 'Acceptance: ApixAccounts',
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

test 'visiting /apix/accounts', (assert) ->
  visit "/"
  andThen =>
    @currentUser.setFrom "email", Fixtures
    @currentUser.setFrom "password", Fixtures
    @currentUser.login()

  andThen =>
    assert.ok @currentUser.get("isLoggedIn"), "our fixtures should get us logged in"
    visit '/apix/accounts'

  andThen ->
    assert.equal currentURL(), '/apix/accounts'
    click ".list-group-item:first-child"

  andThen =>
    assert.ok Cookies.get("simwms-account-session"), "we should have the account session"
    assert.equal Cookies.get("simwms-account-session"), @currentUser.get("permalink")
    assert.ok @currentUser.get("accountLoggedIn"), "we should log the account in successfully"
    assert.ok find("#logout-btn"), "we should be able to logout"
    click "#logout-btn"

  andThen =>
    assert.notOk @currentUser.get("isLoggedIn"), "we should be logged out"
    assert.notOk @currentUser.get("accountLoggedIn"), "account should also be logged out"

