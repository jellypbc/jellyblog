// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// // Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
var _ = require('lodash/core');
ReactRailsUJS.useContext(componentRequireContext)

import 'babel-polyfill';

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';
import 'bootstrap/dist/js/bootstrap';
import 'paper/dist/paper-full';

Rails.start();
Turbolinks.start();

$(function() {
  $('.js-flash-dismiss').on('click', function(e) {
    e.preventDefault();
    return $(e.target).closest('.js-flash-container').hide();
  });
  // close on esc
  return $(document).keyup(function(e) {
    if (e.keyCode === 27) {
      $('.js-flash-container').hide();
    }
  });
});

document.addEventListener("turbolinks:load", function(event){
  ReactRailsUJS.mountComponents()
  if (typeof ga === "function") {
    ga("set", "location", event.data.url);
    ga("send", "pageview");
  }
})
