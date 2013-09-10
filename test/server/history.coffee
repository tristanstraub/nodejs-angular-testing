#-------- TESTS

expect = require 'expect.js'
mockery = require 'mockery'
sinon = require 'sinon'

describe 'history', ->
  afterEach ->
    mockery.disable()
    mockery.deregisterAll()

  beforeEach ->
    mockery.enable warnOnUnregistered: false, useCleanCache: true, warnOnReplace: false

  describe 'readEntries', ->
    history = null
    storage = null

    beforeEach ->
      storage =
        readJsonFile: sinon.spy()

      mockery.registerMock './storage', storage

      history = require '../../src/history'

    it 'should call readJsonFile', ->
      history.readEntries()

      expect(storage.readJsonFile.calledOnce).to.be true

  describe 'writeEntry', ->
    history = null
    storage = null

    beforeEach ->
      storage =
        readJsonFile: -> []
        writeJsonFile: sinon.spy()

      mockery.registerMock './storage', storage

      history = require '../../src/history'

    it 'should call writeJsonFile', ->
      history.writeEntry {}

      expect(storage.writeJsonFile.calledOnce).to.be true
