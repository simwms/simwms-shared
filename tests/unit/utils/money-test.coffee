`import {Money} from 'simwms-shared'`
`import { module, test } from 'qunit'`

module 'Unit | Utility | Money'

# Replace this with your real tests.
test 'it works', (assert) ->
  assert.ok Money
  assert.ok Money?.fromCents

test 'fromCents', (assert) ->
  assert.notOk Money.fromCents(), "it should properly handle null junk"
  assert.equal Money.fromCents(1499), "14.99", "it should properly format simple prices"
  assert.equal Money.fromCents(123099), "1,230.99", "it should properly format big prices"
  assert.equal Money.fromCents(123456789), "1,234,567.89", "it should format really big prices"
