# baby's first gulp config, written in coffeescript
gulp = require 'gulp'
gutil = require 'gulp-util'
clean = require 'gulp-clean'

coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
browserSync = require 'browser-sync'
runSequence = require 'run-sequence'

sources =
  html: 'index.html'
  coffee: './src/coffee/**/*.coffee'
  css: './src/styles/**/*.css'

destinations =
  html: 'dist/'
  js: 'dist/js'
  css: 'dist/css'

# reload the page via browserSync when something changes
gulp.task 'browser-sync', ->
  browserSync.init null,
  open: false
  server:
    baseDir: './dist'
  watchOptions:
    debounceDelay: 1000

# copy static files
gulp.task 'static', ->
  gulp.src(sources.html)
    .pipe(gulp.dest(destinations.html))

  gulp.src(sources.css)
    .pipe(gulp.dest(destinations.css))

# lint coffeescript
gulp.task 'lint', ->
  gulp.src(sources.coffee)
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())

# compile coffeescript
gulp.task 'coffee', ->
  gulp.src(sources.coffee)
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest(destinations.js))

# clean up
gulp.task 'clean', ->
  gulp.src(['dist/'], {read: false}).pipe(clean())

# build it higher
gulp.task 'build', ->
  runSequence 'clean', ['lint', 'coffee', 'static']

# watch and learn
gulp.task 'watch', ->

  # source files
  gulp.watch sources.coffee, ['lint', 'coffee', 'static']
  gulp.watch sources.html, ['static']
  gulp.watch sources.css, ['static']

  # reload the page when something changes in the dest folder
  gulp.watch 'dist/**/**', (file) ->

    browserSync.reload(file.path) if file.type is 'changed'

# setup default task
gulp.task 'default', ['build', 'browser-sync', 'watch']
