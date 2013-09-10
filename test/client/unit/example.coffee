{MineSweeperService, GridController, CellController} = require '../../../assets/js/minesweeper.coffee'

describe 'minesweeper', ->
  describe 'controller', ->
    beforeEach ->
      angular.mock.module 'minesweeper', ($provide) ->
        class MinesweeperServiceMock
          constructor: ->
          start: ->
          resetGame: ->

        $provide.service 'minesweeper', MinesweeperServiceMock

        # This has to be here or we get an error!
        return null

    describe 'constructor', ->
      it 'calls minesweeper.start', ->
        inject ($rootScope, $controller, minesweeper) ->
          sinon.spy minesweeper, 'start'

          $controller GridController, { $scope: $rootScope.$new() }

          expect(minesweeper.start.calledOnce).to.be.true

    describe 'action', ->
      it 'reset should call minesweeper resetGame', ->
        inject ($rootScope, $controller, minesweeper) ->
          sinon.spy minesweeper, 'resetGame'

          scope = $rootScope.$new()

          $controller GridController, { $scope: scope }

          scope.actions.reset()
          expect(minesweeper.resetGame.calledOnce).to.be.true

  describe 'service', ->
    it 'should call /data', ->
      angular.mock.module 'minesweeper'

      inject ($injector, $httpBackend) ->
        myGames = [{randomJunk: 'justOneEntry'}]

        $httpBackend.when('GET', '/data').respond myGames
        $httpBackend.expectGET('/data')

        minesweeper = $injector.get 'minesweeper'

        # Return http calls, and check expectations
        $httpBackend.flush()

        expect(minesweeper.games).to.be myGames
