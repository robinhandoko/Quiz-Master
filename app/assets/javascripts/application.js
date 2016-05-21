// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require turbolinks
//= require bootstrap-sprockets
//= require cocoon
//= require admin/questions
//= require_tree .

var ready = function() {
  $(".submit-answer").click(function(e){
    e.preventDefault();
    counter = 0

    $(".selected-answer").each(function(){
      if($(this).is(":checked")){
        counter += 1;
      }
    })

    if(counter == 0){
      alert("Please select at least one answer");
      return false;
    }

    $("form").submit();
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);