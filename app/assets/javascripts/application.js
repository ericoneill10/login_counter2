// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
	show_login_page()

});

function show_login_page(message) {
	if(!message) message = "Please enter your credentials below";
	$("#top_message").text(message);
	$("#login_form").show();
	$("#bottom_message").hide();
	$("#logout_submit").hide();
	

}

function show_welcome_page(user, count){
	$("#top_message").text("Welcome "+user+"<br>You have logged in "+count+"times.")
	$("#login_form").hide();
	$("#logout_submit").show();

}

function handle_response(data, user){
	var message = ""
	if(data["errCode"]>0){
		show_welcome_page(user, data["count"]);
	}
	else{
		error = data["errCode"];
		if(error == -1){
			message = "Invalid username and password combination";
		}
		if(error == -2){
			message = "User name already exists";
		}
		if(error == -3){
			message = "User name must be non-empty and shorter than 128 characters";
		}
		if(error == -4){
			message = "Password must be shorter than 128 characters";
		}
		$("#top_message").text(message);
	}
}

$('#add_submit').click(function() {
	console.log("a");
	var username = $("#user_user").val()
 	var password = $("#user_password").val()
 	console.log("b");
 	$.ajax({
			  url: '/users/add',
			  type: 'POST',	
	          dataType: 'json',
	          data: {"user":username, "password":password},
	          success: function  (err) {
	          	handle_response(username, err)
	          }
	    });
 	console.log("c");
   return false;
});

$('#login_submit').click(function() {
	console.log("a");
	var username = $("#user_user").val()
 	var password = $("#user_password").val()
 	$.ajax({
			  url: '/users/login',
			  type: 'POST',	
	          dataType: 'json',
	          data: {"user":username, "password":password},
	          success: function  (err) {
	          	handle_response(username, err)
	          }
	    });

   return false;
});

$('#logout_submit').click(function() {
  show_login_page();

  return false;
});





