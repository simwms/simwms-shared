`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'session', 'Unit | Model | session', {
  # Specify the other units that are required for this test.
  needs: ["model:user"]
}

test 'it exists', (assert) ->
  model = @subject
    email: "fox@fox.fox"
  # store = @store()
  assert.ok model
