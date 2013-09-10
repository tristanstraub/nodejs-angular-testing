fs = require 'fs'

module.exports.readJsonFile = (path) ->
  return JSON.parse fs.readFileSync path

module.exports.writeJsonFile = (path, collection) ->
  fs.writeFileSync path, JSON.stringify collection, { flags: '+' }
