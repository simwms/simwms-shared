`import Ember from 'ember'`

freeMsg = (ctrl) -> """
You tried to free #{ctrl}, but it was never enslaved in the controller pen in the first place
"""

negMsg = """
You tried to free more controllers than you had, this is likely an oversight on your part
"""

WorkersUnionService = Ember.Service.extend
  ctrlCenter: new Ember.Map()
  busyWorkers: 0
  isBusy: Ember.computed.not "isFree"
  isFree: Ember.computed.equal "busyWorkers", 0
  
  makeBusy: Ember.on "controllerWorking", (ctrl) ->
    return if @ctrlCenter.get(ctrl) is "busy"
    @ctrlCenter.set ctrl, "busy"
    @incrementProperty "busyWorkers", 1

  makeFree: Ember.on "controllerFinished", (ctrl) ->
    throw new Error freeMsg(ctrl) unless @ctrlCenter.has ctrl
    return if @ctrlCenter.get(ctrl) is "free"
    @ctrlCenter.set ctrl, "free"
    @decrementProperty "busyWorkers", 1
    throw new Error negMsg if @get("busyWorkers") < 0

`export default WorkersUnionService`
