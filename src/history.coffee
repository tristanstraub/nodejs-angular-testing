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
