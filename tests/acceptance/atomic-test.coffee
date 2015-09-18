`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../../tests/helpers/start-app'`

module 'Acceptance: Atomic',
  beforeEach: ->
    @application = startApp()
    ###
    Don't return anything, because QUnit looks for a .then
    that is present on Ember.Application, but is deprecated.
    ###
    @atomic = @application.__container__.lookup("controller:atomic")
    @appCtrl = @application.__container__.lookup("controller:application")
    return

  afterEach: ->
    Ember.run @application, 'destroy'

test 'proper setup', (assert) ->
  visit "/"
  andThen =>
    assert.ok @atomic.workersUnion, "the workers union is properly injected"
    assert.equal typeof @atomic.atomically, "function", "the atomically method exists"

test 'visiting /atomic', (assert) ->
  visit '/atomic'

  assert.equal @atomic.get("isBusy"), false, "starts out free"
  assert.equal @atomic.get("submitClicked"), false, "nothing is clicked yet"
  assert.equal @appCtrl.get("workersUnion.isBusy"), false, "the union starts out not busy"

  andThen =>
    assert.equal currentURL(), '/atomic', "should be on the right path"
    @atomic.send "submit"
    assert.equal @atomic.get("submitClicked"), true, "should receive click submit event"
    assert.equal @atomic.get("isBusy"), true, "in an atomic operation, the controller is busy"
    assert.equal @appCtrl.get("workersUnion.isBusy"), true, "the union is busy if any atomic controller is busy"

  andAfterward =>
    assert.equal @atomic.get("isBusy"), false, "the controller is no longer busy"
    assert.equal @appCtrl.get("workersUnion.isBusy"), false, "the union is no longer busy"