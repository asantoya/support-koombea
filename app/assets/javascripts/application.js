// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require twitter/bootstrap
//= require_tree .
$(document).on("ready", function () {
  setTimeout(function  () {
    $(".alert").fadeOut("slow")
  },3000);

  $("#new_comment").submit( function () {
    $(".loader img").show()
  })

  $(".pagination").find("a").attr("data-remote", true);

  $(".add_fields").on("click", function (event) {
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    $(this).html("Add more files")
  })
  $(".filters i a").on("click", function  () {
    $(".filters i").removeClass('active');
    $(this).parent().addClass('active');
  })
})