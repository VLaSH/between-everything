BetweenEverythingView = require './between-everything-view'
{CompositeDisposable} = require 'atom'

module.exports = BetweenEverything =
  betweenEverythingView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @betweenEverythingView = new BetweenEverythingView(state.betweenEverythingViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @betweenEverythingView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'between-everything:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @betweenEverythingView.destroy()

  serialize: ->
    betweenEverythingViewState: @betweenEverythingView.serialize()

  toggle: ->
    console.log 'BetweenEverything was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
