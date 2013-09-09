fs = require 'fs'
path = require 'path'

storage = require './storage'

historyPath = path.resolve(path.join(__dirname, 'history.json'))

module.exports.readEntries = readEntries = ->
  try
    history = storage.readJsonFile historyPath
  catch e
    history = []

  return history

module.exports.writeEntry = (entry) ->
  entries = readEntries()
  entries.push entry

  storage.writeJsonFile historyPath, entries

#-------- TESTS

# expect = require 'expect.js'
# mockery = require 'mockery'

# describe 'history', ->
#   afterEach ->
#     mockery.disable()
#     mockery.deregisterAll()

#   beforeEach ->
#     mockery.enable warnOnUnregistered: false, useCleanCache: true, warnOnReplace: false

#   describe 'With mocking, ', ->
#     it 'require can return null', ->
#       mockery.registerMock './storage', null
#       storage = require './storage'
#       expect(storage).to.be null

#     it 'require can return an object', ->
#       mockery.registerMock './storage', null
#       storage = require './storage'
#       expect(storage).to.be
