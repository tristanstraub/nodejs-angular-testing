path = require 'path'
express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
livereload = require 'express-livereload'
browserify = require 'browserify-middleware'
coffeeify = require 'coffeeify'

history = require './history.coffee'

app = express()
app.use express.bodyParser()


browserify.settings
  transform: [coffeeify]

app.get('/js/minesweeper.js', browserify(path.resolve(path.join(__dirname, '../assets/js/minesweeper.coffee'))))

livereload app,
 	watchDir: path.resolve(__dirname, '../')

compile = (str, path) ->
  stylus(str)
    .set('filename', path)
    .use(nib())

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.use express.logger('dev')

# *.styl files
app.use(
  stylus.middleware (
    src: path.resolve(path.join(__dirname, '../public'))
    compile: compile
  )
)

# Scripts ,etc
app.use express.static(path.resolve(__dirname, '../public'))

app.get '/', (req, res) ->
  res.render 'index'

app.get '/data', (req, res) ->
  res.json history.readEntries()

app.post '/data', (req, res) ->
  history.writeEntry req.body.game
  res.json status: 'ok'

app.listen(3000)

console.log 'Listening on port 3000'

