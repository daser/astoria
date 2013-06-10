jQuery(function() {
	$('#personal-data').submit(function(event){
		event.preventDefault();
		var f = $(this);
 		f.find('.message').html("Saving");
 		f.find('input[type="submit"]').attr('disabled', 'disabled');

 		$.ajax({
 			url: f.attr('action'),
 			type: f.attr('method'),
 			dataType: "html",
 			data: f.serialize(),
 			complete:function(){
  				f.find('input[type="submit"]').attr('disabled', 'disabled');
  				$("#kai").hide();
 				$("#jiki").hide();
 				$("#kainasara").show();
 				f.remove();

 			},
 			success:function(data,textStatus,xhr){
 				$("#kai").hide();
 				$("#jiki").hide();
 				$("#kainasara").show();
 				f.remove();
 			},
 			error:function(){

 			}
 		});
 	});
});