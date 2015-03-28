gulp = require 'gulp'
coffee = require 'gulp-coffee'
browserSync = require 'browser-sync'

gulp.task 'coffee', () ->
    gulp.src 'js/*.coffee'
        .pipe coffee()
        .pipe gulp.dest('./js')

gulp.task 'watch',()->
  gulp.watch './js/*.coffee',['coffee']

gulp.task 'serve',() ->
  browserSync
    notify: false
    logPrefix: 'IDI'
    server: './'

gulp.task 'default',['watch','serve']
