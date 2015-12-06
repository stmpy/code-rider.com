module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    less:

      development:
        options:
          paths: ['less', 'bower_components/bootstrap/less']
        files:
          'public/css/app.css': 'less/bootstrap.less'

      production:
        options:
          paths: ['less', 'bower_components/bootstrap/less'],
          plugins: [
            new (require('less-plugin-autoprefix'))({browsers: ["last 2 versions"]}),
            new (require('less-plugin-clean-css'))( { advanced: true } ) # https://github.com/jakubpawlowicz/clean-css
          ]
        files:
          "path/to/result.css": "path/to/source.less"

    copy:

      images:
        src: 'images/*'
        dest: 'public/'
        filter: 'isFile'

      templates:
        expand: true
        cwd: 'templates/'
        src: '*'
        dest: 'public/'
        filter: 'isFile'

    watch:

      config:
        options:
          reload: true
        files: ['Gruntfile.coffee']

      less:
        files: ['less/*.less']
        tasks: ['less:development']

      templates:
        files: ['templates/*']
        tasks: ['copy:templates']

      images:
        files: ['images/*']
        tasks: ['copy:images']


  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ['less','copy']
