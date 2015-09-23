$(document).ready(function(){
//   $(".product-img:file").first().on('change' ,function(){
//     var a = ($(this).val());
//     if(a.length != 0){
//       $("#add-img").show();
//     }
//   });

//   $("#add-img").click(function(e){
//     e.preventDefault();
//     var count = $(".product-img").length;
//     var id = "product[images_attributes]["+count+"][avatar]";
//     var d_field = '<input class="form-control product-img" id="nested-image" type="file" name="'+id+'">';
//     var el = $('.product-img:last');
//     $(el).after(d_field);
//   });
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

    // var id = $("#product_id").val();
    // var url_link = '/products/'+id+'/product_categories'
    // $('#category').tagsinput({
    //   typeahead: {
    //     source: function(query) {
    //       return $.ajax({
    //         url: url_link,
    //         type: 'get',
    //         dataType: 'json',
    //         success: function(json) {
    //           return typeof json;
    //         }
    //       });
    //     }
    //   }
    // });

});

