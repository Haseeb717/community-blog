$(document).ready(function(){
  

  $('.select-option').on('change', function() {
    var rate_val =  this.value ;
    var url_link = '/home/user_sorted'
    $.ajax({
        url: url_link,
        type: "GET",
        data: {rate_val: rate_val},
        success: function (data) {
            
        }
    });

  });
});
