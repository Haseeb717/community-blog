$(document).ready(function(){


  $(".icon-like").click(function() {
    var id = $("#product_id").val();
    var url_link = '/products/'+id+'/product_likes_and_dislikes';
    var current_id = $(this).attr('id');
    $.ajax({
        url: url_link,
        type: "POST",
        data: {type: $(this).attr('id')},
        success: function (data) { 
            // append data to your page
            //if(data.message = "success")
                $("#"+current_id).css("background-image", "url('/assets/img-5-h.png')"); 
        }
    });
  });

    $(function() {
      $("#category").tokenInput("/products/product_categories.json", {
        crossDomain: false,
        prePopulate: $("#category").data("pre"),
        theme: "facebook"
      });
    });

    

});

