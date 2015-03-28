gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'coffee', () ->
    gulp.src 'js/*.coffee'
        .pipe coffee()
        .pipe gulp.dest('./js')

gulp.task 'watch',()->
  gulp.watch './js/*.coffee',['coffee']

gulp.task 'default',['coffee']
