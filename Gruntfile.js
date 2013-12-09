'use strict';

module.exports = function(grunt) {

    grunt.loadNpmTasks('grunt-contrib');

    grunt.initConfig({
        less: {
            gen: {
                options: { cleancss: true },
                src: "./src-front/less/oyabun.less",
                dest: "./src-front/less/oyabun.css"
            }
        },
        cssmin:{
            main: {
                src : ["./src-front/less/oyabun.css"],
                dest : "./priv/static/oyabun/oyabun.min.css"
            }
        },
        uglify: {
            options: {
                mangle: true
            },
            gen: {
                files: {
                    './priv/static/oyabun/oyabun.min.js': ['./src-front/js/app.js']
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