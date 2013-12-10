'use strict';

module.exports = function(grunt) {

    grunt.loadNpmTasks('grunt-contrib');

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        less: {
            gen: {
                options: { cleancss: true },
                src: "./src-front/less/<%= pkg.name %>.less",
                dest: "./src-front/less/<%= pkg.name %>.css"
            }
        },
        cssmin:{
            main: {
                src : ["./src-front/less/<%= pkg.name %>.css"],
                dest : "./priv/static/<%= pkg.name %>/<%= pkg.name %>.min.css"
            }
        },
        uglify: {
            options: {
                mangle: true
            },
            gen: {
                files: {
                    './priv/static/<%= pkg.name %>/<%= pkg.name %>.min.js': ['./src-front/js/app.js']
                }
            }
        },
        clean: {
            css: ["<%= cssmin.main.src %>"]
        },
        watch: {
            less: {
                files: ["./src-front/less/*.less"],
                tasks: ["gencss"]
            },
            js: {
                files: ["./src-front/js/*.js"],
                tasks: ["genjs"]
            }
        }
    });

    grunt.registerTask("gencss", ["less", "cssmin", "clean:css"]);
    grunt.registerTask("genjs", ["uglify"]);
};