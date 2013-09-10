# MOCHA TESTS
describe 'mocha is a test runner that runs our tests. It allows us to', ->

  describe 'group tests', ->

    describe 'and subgroups of tests', ->

      describe 'together with the thing we are testing. We expect that it', ->

        it 'should be able to run a test successfully', ->
          # No error in here

        it.skip 'can be skipped', ->

        # it.only 'run exclusively', ->

        it 'shouldnt timeout if we call done for asynchronous tests', (done) ->
          done()

        it.skip 'should timeout when we forget to call done', (done) ->

      describe.skip 'can wrap tests with before, after, beforeEach, and afterEach', ->
        before ->
          console.log ""
          console.log ""
          console.log "  <========== BEFORE ============>"
          console.log ""

        beforeEach =>
          console.log ""
          console.log ""
          console.log "  <========== BEFORE=EACH =======>"
          console.log ""

        afterEach =>
          console.log ""
          console.log "  <========== AFTER=EACH ========>"
          console.log ""

        after =>
          console.log ""
          console.log ""
          console.log "  <========== AFTER =============>"
          console.log ""

        it 'should show before, and beforeEach', ->

        it 'should show afterEach, beforeEach', ->

      describe 'can get the name of', ->

        beforeEach ->
          console.log ""
          console.log ""
          console.log "  <======== I am #{@currentTest.title} ========>"
          console.log ""

        it 'the current running test', ->


# EXPECT.JS

expect = require 'expect.js'

describe.skip 'expect.js', ->

  describe 'provides "expect"', ->

    it 'to compare things', ->
      expect(1).to.be 1
      expect(1).to.eql "1"
      expect(1).to.not.equal "1"
      expect(1).to.equal 1

    it 'to fail when 2+2 doesn\'t equal 5', ->
      expect(2+2).to.equal 5

    it 'to observe an UNexpected that is thrown', ->
      functionThatThrowsAnError = ->
        throw new Error 'An unexpected error!'

      functionThatThrowsAnError()

    it 'to observe an EXPECTED that is thrown', ->
      functionThatThrowsAnError = ->
        throw new Error 'An unexpected error!'

      expect(functionThatThrowsAnError).to.throwError()

# MOCKERY

expect = require 'expect.js'
mockery = require 'mockery'

describe 'mockery', ->
  afterEach ->
    mockery.disable()
    mockery.deregisterAll()

  beforeEach ->
    mockery.enable warnOnUnregistered: false, useCleanCache: true, warnOnReplace: false

  describe 'mockery can cause', ->

    it 'require to return null', ->

      mockery.registerMock 'fs', null

      fs = require 'fs'
      expect(fs).to.be null

    it 'require to return an object', ->

      mockery.registerMock './storage',
        someFunctionWeAreMocking: ->

      storage = require './storage'
      expect(storage.someFunctionWeAreMocking).to.be.ok()

# SINONJS

sinon = require 'sinon'
describe.skip 'sinon helps us to spy', ->
  describe 'on functions', ->
    it 'where we expect them to be called', ->
      fn = sinon.spy()

      fn()

      expect(fn.calledOnce).to.be true

    it 'where we expect them to be called with certain parameters', ->
      fn = sinon.spy()

      fn 1, 2, 3

      expect(fn.calledWith(1, 2, 3)).to.be true

    it 'where we expect an objects method to have been called', ->
      class Thing
        constructor: ->
          @iWasCalled = false

        justDoIt: ->
          @iWasCalled = true

      thing = new Thing()

      sinon.spy(thing, 'justDoIt')

      expect(thing.iWasCalled).to.be false

      thing.justDoIt()

      # Both of these should be the same

      expect(thing.iWasCalled).to.be true
      expect(thing.justDoIt.calledOnce).to.be true
