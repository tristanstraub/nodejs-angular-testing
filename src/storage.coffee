
module.exports.readJsonFile = (path) ->
  return JSON.parse fs.readFileSync path

module.exports.writeJsonFile = (path, collection) ->
  fs.writeFileSync historyPath, JSON.stringify collection, { flags: '+' }
