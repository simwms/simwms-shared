`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import {validateAccount} from 'simwms-shared'`
`import startApp from '../../tests/helpers/start-app'`
`import andAfterward from '../../tests/helpers/and-afterward'`

userParams =
  email: "test-email-no-#{Math.random()}@testmail.co"
  password: "password123"
  username: "test-user-no-#{Math.random()}"

accountParams =
  companyName: "Test Co #{Math.random()}"
  timezone: "America/Los_Angeles"

module 'Acceptance: CurrentAccount',
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

test 'account creation and session', (assert) ->
  visit '/'
  accountToken = null
  andThen => 
    @store.createRecord "user", userParams
    .save()
  andThen =>
    @currentUser.login userParams
  andThen =>
    @store.createRecord "account", accountParams
    .save()
    .then (account) =>
      accountToken = account.get("permalink")
      assert.ok account.id, "the account should be made"
      assert.ok accountToken, "the account should have its permalink"
      @currentUser.accountLogin(account)
    .catch (errors) ->
      assert.deepEqual errors, {}, "we should be able to make accounts"
  andThen =>
    plan = @currentUser.get("servicePlan")
    assert.ok plan, "we should have the service plan"
    assert.equal plan.get("docks"), 1, "plan docks amounts should match"
    assert.equal plan.get("warehouses"), 4, "plan warehouses amounts should match"
    assert.equal plan.get("employees"), 5, "plan employees amounts should match"
    assert.equal plan.get("scales"), 1, "plan scales amounts should match"
  andThen =>
    meta = @currentUser.get("meta")
    assert.ok meta, "the meta detail should be there"
    assert.equal meta.get("docks"), 1, "docks"
    assert.equal meta.get("warehouses"), 1, "warehouses"
    assert.equal meta.get("employees"), 1, "employees"
    assert.equal meta.get("scales"), 1, "scales"
    validateAccount meta
    .then (meta) ->
      assert.ok meta, "we should get here"
    .catch (errors) ->
      assert.deepEqual errors.core, {}, "we should pass account validation"
  andThen =>
    assert.ok @currentUser.get("accountLoggedIn"), "the account should be logged in"
    assert.ok @currentUser.get("account"), "the account should be there"
    assert.ok @currentUser.get("employee"), "the employee should be there"
    assert.ok @currentUser.get("servicePlan"), "the account service plan should be there"
    @currentUser.accountLogout()
    assert.notOk @currentUser.get("accountLoggedIn"), "account logout should work"
  andThen =>
    @currentUser.logout()

  andThen =>
    @currentUser.smartLogin
      email: userParams.email
      password: userParams.password
      accountToken: accountToken
  andThen =>
    assert.ok @currentUser.get("isLoggedIn"), "smart login should log in user"
    assert.ok @currentUser.get("accountLoggedIn"), "smart login should log in the account"
    assert.equal @currentUser.get("account.permalink"), accountToken, "we should have the right account"
    assert.equal @currentUser.get("session.email"), userParams.email, "the right employee should be logged in"
  andThen =>
    @currentUser.accountLogout()
    @currentUser.logout()