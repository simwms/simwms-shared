`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../../tests/helpers/start-app'`
`import Fixtures from '../../tests/helpers/fixtures'`

module 'Acceptance: ApizAppointments',
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
    Cookies.remove "simwms-account-session"
    return

  afterEach: ->
    Cookies.remove "simwms-user-session"
    Cookies.remove "simwms-account-session"
    Ember.run @application, 'destroy'

test 'visiting /apiz/appointments', (assert) ->
  visit "/"

  andThen =>
    @currentUser.smartLogin Fixtures

  andThen =>
    assert.ok @currentUser.get("isLoggedIn"), "our fixtures should get us logged in"
    assert.ok @currentUser.get("accountLoggedIn"), "we should log the account in successfully"
    visit "/apiz/appointments"

  andThen =>
    assert.equal currentURL(), '/apiz/appointments'
    assert.ok find(".list-group-item").length > 1
    click "#logout-btn"
