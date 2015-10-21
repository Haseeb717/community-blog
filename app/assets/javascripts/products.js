$(document).ready(function(){

    jQuery(".best_in_place").best_in_place();
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

    $(".product-img:file").first().on('change' ,function(){
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

 });

