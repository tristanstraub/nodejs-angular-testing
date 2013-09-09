
require('coffee-script');

// Karma configuration
// Generated on Thu Jul 25 2013 10:24:51 GMT+1000 (EST)
module.exports = function(config) {
  config.set({
    browserify: {
      extension: ['.coffee'],
      transform: ['coffeeify'],
      watch: true
    },

    // base path, that will be used to resolve files and exclude
    basePath: '../../lib/angular',

    // frameworks to use
    frameworks: ['mocha', 'expect', 'browserify'],

    // list of files / patterns to load in the browser
    files: [
      '../../public/scripts/jquery-2.0.2.min.js',
      '../../public/scripts/angular-1.1.5.min.js',
      '../../public/scripts/angular-mocks-1.1.5.min.js',
      '../../public/scripts/sinon-1.7.3.js',
      // Unit tests
      '../../test/client/unit/**/*.coffee'
    ],


    // list of files to exclude
    exclude: [

    ],


    preprocessors: {
      '**/*.coffee': 'coffee',
      '../../test/client/**/*.coffee': 'browserify',

      // code coverage paths
      'controllers/**/*.coffee': 'coverage',
      'services/**/*.coffee': 'coverage',
      'directives/**/*.coffee': 'coverage'
    },


    // http://karma-runner.github.io/0.8/config/coverage.html
    coverageReporter: {
      type : 'text',
      dir : 'coverage/'
    },


    // test results reporter to use
    // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['dots', 'coverage'],


    // web server port
    port: 9876,


    // cli runner port
    runnerPort: 9100,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['PhantomJS'],


    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: (process.env.NODE_ENV === 'ci')
  });
};
