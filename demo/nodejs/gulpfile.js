'use strict';

var gulp = require('gulp'),
    watch = require('gulp-watch'),
    prefixer = require('gulp-autoprefixer'),
    uglify = require('gulp-uglify'),
    less = require('gulp-less'),
    sourcemaps = require('gulp-sourcemaps'),
    rigger = require('gulp-rigger'),
    cssnano = require('gulp-cssnano'),
    imagemin = require('gulp-imagemin'),
    pngquant = require('imagemin-pngquant'),
    del = require('del'),    
    jshint = require('gulp-jshint'),

    mainBowerFiles = require('gulp-main-bower-files'),
    concat = require('gulp-concat'),
    gulpFilter = require('gulp-filter'),

    browserSync = require("browser-sync"),
    reload = browserSync.reload;

var path = {
    build: {
        html: 'html/',
        js: 'html/js/',
        css: 'html/css/',
        img: 'html/img/',
        fonts: 'html/fonts/',
        vendor: 'html/assets/'
    },
    src: {
        html: 'src/*.html',
        js: 'src/js/main.js',
        style: 'src/style/main.less',
        img: 'src/img/**/*.*',
        fonts: 'src/fonts/**/*.*'
    },
    watch: {
        html: 'src/**/*.html',
        js: 'src/js/**/*.js',
        style: 'src/style/**/*.less',
        img: 'src/img/**/*.*',
        fonts: 'src/fonts/**/*.*'
    },
    clean: './html'
};

var config = {
    server: {
        baseDir: "./html"
    },
    tunnel: true,
    host: 'localhost',
    port: 9000,
    logPrefix: "APP"
};

gulp.task('webserver', function () {
    browserSync(config);
});

gulp.task('clean', function (cb) {
    del(path.clean, cb);
});

gulp.task('build:html', function () {
    gulp.src(path.src.html) 
        .pipe(rigger())
        .pipe(gulp.dest(path.build.html))
        .pipe(reload({stream: true}));
});

gulp.task('lint', function() {
  gulp.src(['src/js/partials/*.js', '!./lib/**'])
    .pipe(jshint())
    .pipe(jshint.reporter('default'))
    .pipe(jshint.reporter('fail'));
});

gulp.task('build:js', function () {
    gulp.src(path.src.js)
        .pipe(rigger())
        .pipe(sourcemaps.init())
//        .pipe(uglify()) 
//        .pipe(sourcemaps.write()) 
        .pipe(gulp.dest(path.build.js))
        .pipe(reload({stream: true}));
});

gulp.task('build:style', function () {
    gulp.src(path.src.style) 
        .pipe(sourcemaps.init())
        .pipe(less({
            includePaths: ['src/style/'],
            outputStyle: 'compressed',
            sourceMap: true,
            errLogToConsole: true
        }))
        .pipe(prefixer())
        .pipe(cssnano())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(path.build.css))
        .pipe(reload({stream: true}));
});

gulp.task('build:image', function () {
    gulp.src(path.src.img) 
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant()],
            interlaced: true
        }))
        .pipe(gulp.dest(path.build.img))
        .pipe(reload({stream: true}));
});

gulp.task('build:fonts', function() {
    gulp.src(path.src.fonts)
        .pipe(gulp.dest(path.build.fonts))
});

var filterByExtension = function(extension){  
    return gulpFilter(function(file){
        return file.path.match(new RegExp('.' + extension + '$'));
    });
};

gulp.task('bower2', function() {

/*  return gulp.src(mainBowerFiles(), {
      base: 'lib'
    })
 */
 var jsFilter = gulpFilter('**/*.js', {restore: true});
    return gulp.src('./bower.json')
        .pipe(mainBowerFiles({
            overrides: {
                bootstrap: {
                    main: [
                        './dist/js/bootstrap.js',
                        './dist/fonts/*.*'
                    ]
                }
            }
        }))
        .pipe(jsFilter)
        .pipe(uglify({preserveComments: 'license'}))
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest(path.build.js))
        .pipe(jsFilter.restore)
        .pipe(filterByExtension('css'))
        .pipe(prefixer())
        .pipe(cssnano())
        .pipe(concat('assets.css'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(path.build.css));
});

gulp.task('bower1', function(){  
    var mainFiles = mainBowerFiles();

  //  if(!mainFiles.length){
        // No main files found. Skipping....
  //      return;
  //  }

    var jsFilter = filterByExtension('js');

    return gulp.src('./bower.json')
        .pipe(mainBowerFiles())
        .pipe(jsFilter)
        .pipe(concat('third-party.js'))
        .pipe(gulp.dest(path.build.js))
        .pipe(jsFilter.restore())
        .pipe(filterByExtension('css'))
        .pipe(concat('third-party.css'))
        .pipe(gulp.dest(path.build.css));
});

gulp.task('bower', function() {
    var filterJS = gulpFilter('**/*.js', { restore: true });
    return gulp.src('./bower.json')
        .pipe(mainBowerFiles({
            overrides: {
                bootstrap: {
                    main: [
                        './dist/js/bootstrap.js',
                        './dist/css/*.min.*',
                        './dist/fonts/*.*'
                    ]
                }
            }
        }))
        .pipe(filterJS)
        .pipe(concat('vendor.js'))
        .pipe(uglify())
        .pipe(filterJS.restore)
        .pipe(gulp.dest(path.build.vendor));
});
gulp.watch('bower.json',['bower']);

gulp.task('build', [
    'build:html',
    'build:js',
    'build:style',
    'build:fonts',
    'build:image'
]);


gulp.task('watch', function(){
    watch([path.watch.html], function(event, cb) {
        gulp.start('build:html');
    });
    watch([path.watch.style], function(event, cb) {
        gulp.start('build:style');
    });
    watch([path.watch.js], function(event, cb) {
        gulp.start('build:js');
    });
    watch([path.watch.img], function(event, cb) {
        gulp.start('build:image');
    });
    watch([path.watch.fonts], function(event, cb) {
        gulp.start('build:fonts');
    });
});


gulp.task('default', ['build', 'webserver', 'watch']);
