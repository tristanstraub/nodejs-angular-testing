app = angular.module 'minesweeper', []

app.service 'minesweeper', class MineSweeper
  playing: false
  rows: []
  steps: []
  games: []

  status: ''

  @$inject: ['$http']
  constructor: (@http) ->
    @http.get('/data').success (data) =>
      console.log data
      @games = data

  start: ->
    @playing = true
    @status = '...PLAYING...'
    @steps = []

    @initGrid 10, 10

    return @rows

  viewGame: (index) ->
    @rows = @games[index].rows
    @steps = @games[index].steps
    @status = @games[index].status
    @playing = @games[index].playing

    return @rows


  saveGame: ->
    console.log 'saving'
    game =
      playing: @playing
      status: @status
      rows: @rows
      steps: @steps
    @games.push game
    @http.post '/data', {game}, headers: {
      'Content-type': 'application/json'
    }

  clickedCell: (cell) ->
    if @playing
      @steps.push [cell.rowIndex, cell.colIndex]
      cell.isCovered = false
      if cell.isBomb
        @playing = false
        @status = 'LOST!'
        @saveGame()
      
  initGrid: (w, h) ->
    nRows = w
    nCols = h
    rows = rows = []
    for i in [0...nRows]
      row = []
      rows.push row

      for j in [0...nCols]
        row.push
          rowIndex: i
          colIndex: j
          class: 'covered'
          isBomb: Math.random()>0.8
          isCovered: true
          neighbourBombs: 0

    isBombInteger = (cell) ->
      if cell.isBomb then 1 else 0
  
    getNeighboursBombCount = (cell) ->
      count = 0
      for u in [-1..1]
        for v in [-1..1]
          if not (u is 0 and v is 0) and cell.rowIndex+u >= 0 and cell.rowIndex+u < nRows and cell.colIndex+v >= 0 and cell.colIndex+v < nCols
            count += isBombInteger rows[cell.rowIndex+u][cell.colIndex+v]
      return count

    for row in rows
      for cell in row
        cell.neighbourBombs = getNeighboursBombCount(cell)

    @rows = rows

app.controller 'grid', ($scope, minesweeper) ->
  $scope.minesweeper = minesweeper

  resetGame = ->
    $scope.rows = minesweeper.start()

  $scope.actions =
    reset: ->
      resetGame()
    viewGame: (index) ->
      $scope.rows = minesweeper.viewGame index
      

  resetGame()

app.controller 'cell', ($scope, minesweeper) ->
  $scope.actions = 
    clickCell: ->
      minesweeper.clickedCell $scope.cell  


