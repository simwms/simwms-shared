`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`
`import andAfterward from '../../tests/helpers/and-afterward'`

userParams =
  email: "test-email-no-#{Math.random()}@testmail.co"
  password: "password123"
  username: "test-user-no-#{Math.random()}"

module 'Acceptance: LoginTokens',
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

test 'registration and session', (assert) ->
  visit '/'
  assert.ok @store, "the store should be in the index"
  assert.equal typeof @store.find, "function", "the store should be the DS store"
  assert.ok @currentUser, "currentUser should be injected into a route"
  assert.equal typeof @currentUser?.store?.find, "function", "currentUser have the store service"
  andThen =>
    assert.notOk @currentUser.get("isLoggedIn"), "we should start not logged in"
    @store.createRecord "user", userParams
    .save()
    .then (user) =>
      assert.equal user.get("email"), userParams.email
      assert.equal user.get("username"), userParams.username
    .catch (errors) =>
      assert.deepEqual errors, {}, "should not get here"
  andThen =>
    @currentUser.set "email", userParams.email
    @currentUser.set "password", "wrong-pass"
    @currentUser.login()
    .catch (errors) ->
      assert.ok errors, "we should have not be logged in given the wrong password"
    .finally =>
      errors = @currentUser.get("errors")
      assert.notOk @currentUser.get("isLoggedIn"), "we should not be logged in with the wrong password"
      assert.ok errors, "we should have the errors object"
      expected =
        password: ["wrong password"]
        email: []
        token: []
        system: []
      assert.deepEqual errors.get("core"), expected, "we should have the password error"
  andThen =>
    @currentUser.set "email", userParams.email
    @currentUser.set "password", userParams.password
    @currentUser.login()
    .then (session) ->
      assert.notOk session.get("hasErrors"), "we should not have errors"
      assert.ok session.get("isLoggedIn"), "login should work"
      session
    .catch (errors) ->
      assert.deepEqual errors, {}, "we should not get here"
    .then (session) =>
      @store.find "session", "test-session"
      .then (s2) ->
        assert.ok s2, "we should get here"
      .catch (errors) ->
        assert.deepEqual errors, {}, "finding the singleton session should work"
      .then =>
        @currentUser.logout()
      .then (session) ->
        assert.notOk session.get("isLoggedIn"), "we should be logged out"
      .catch (errors) ->
        assert.notOk true, "logging out should not cause trouble"
  andThen =>
    @currentUser.login userParams
    .then (session) ->
      assert.notOk session.get("hasErrors"), "repeated login should still produce no errors"
      assert.ok session.get("isLoggedIn"), "repeated login should work properly"
    .then =>
      @store.findAll "account"
    .then =>
      assert.ok true, "finding the accounts should be ok"
    .catch =>
      assert.ok true, "finding the account when logged in should not fail"
    .finally =>
      @currentUser.logout()