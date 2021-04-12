// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')

import $ from 'jquery';
global.$ = jQuery;
import '../stylesheets/application'
import 'materialize-css/dist/js/materialize'
import 'fullcalendar/main'


// $(document).on('turbolinks:click', function() {
//   console.log("on click")
//   $('.preloader-wrapper').removeClass("d-none")
// });

// $(document).on('turbolinks:load', function() {
//   console.log("on hide loader")
//   $('.preloader-wrapper').addClass("d-none")
// });

import "controllers"
import "animate.css"
