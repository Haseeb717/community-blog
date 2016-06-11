$(document).ready(function(){

    jQuery(".best_in_place").best_in_place();

    $('a.colorbox').colorbox();


    $(document).on('click', '#delete-img', function(){
      var checkValues = $('input[name=image_id]:checked').map(function(){
          return $(this).val();
      }).get();
      console.log(checkValues);
      var id = $("#product_id").val();
      if(checkValues.length == 0) {
          alert("Select any image to delete");
      }
      else{
          $.ajax({
              url: '/products/delete_product_images.js',
              type: 'delete',
              data: { ids: checkValues, id: id }
          });
      }  
    });

    $(document).on('change' , '.product-img:file',function(){
      var a = ($(this).val());
      if(a.length != 0){
        $("#add-img").show();
      }
    });

    function readURL(input) {
      if (input.files && input.files[0]) {
          var reader = new FileReader();
          var last = input.id;
          reader.onload = function (e) {
            var file = e.target;
            $('#'+last+'preview').attr('src', e.target.result);
            $('.target').show();
          }
          reader.readAsDataURL(input.files[0]);
      }
      else
      {
        var last = input.id;
        $('#'+last+'preview').hide();
      }
    }
    
    
    $(document).on('change', '.abc', function(){
      readURL(this);
    });
    
    $(document).on('click', '#add-img', function(){
      var last_one = $(".product-img:last").val();
      
      if(last_one.length!=0){
        
        var count = $(".product-img").length;
        var name = "product[images_attributes]["+count+"][avatar]";
        var d_field = '<input class="form-control product-img abc" id="imgInp'+count+'" style="margin-top:10px;" type="file" name="'+name+'">';
        var el = $('.product-img:last');
        $(el).after(d_field);
        var d_img_preview = $("<img></img>",{
          class : "target",
          id : "imgInp"+count+"preview",
          src : ""
        });
        $('.preview_img_div').append(d_img_preview);
      }
      else{
        alert("Fill previous one first")
      }
    });

    $(document).on('click', '.fa-pencil', function(){
      var t = $(this).attr('id');
      $('.text-field #'+t).click();
    });

    $(document).on('click', '.fa-reply', function(){
      var t = $(this).attr('id');
      $("#"+t+"div").show();
      
    });

    $(document).on('keypress', '.reply-comment',function(e){
        if (e.keyCode == 13 && !e.shiftKey) {
            var comment = $(this).val();
            var current_id = $(this).attr('id');
            var product_id = $("#product_id").val();
            var url_link = '/products/'+product_id+'/product_reply_comment';
            $.ajax({
                url: url_link,
                type: "POST",
                data: {parent_id: current_id, id: product_id,comment: comment}
                
            });
        }

    });

    $(document).on('click','.load_reply',function(e){
      var t = $(this).attr('id');
      $("#"+t+"div").show();
      $(this).hide();
    });

 });

