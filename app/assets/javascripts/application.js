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
//= require_tree ../../../vendor/assets-plugins/jquery/js
//= require_tree ../../../vendor/assets-plugins/bootstrap/js
//= require turbolinks
//= require_tree .

function set_like(number){
	if(number !=0 && number !=1){ 
		return " likes";
	}
	else{
		return " like";
	}
}
$(document).ready(function(){
	$("a[data-remote]").on('click', function(){
			var like = $(this).data('value');
			var id = $(this).data('id')
			like++;
			$('#like_id_'+id).text(like + set_like(like));
			var text = $('<p>You liked it</p>');
			$('.count ').find('#like_id_'+id).prepend(text);
			$(this).remove();
	});
});
  	