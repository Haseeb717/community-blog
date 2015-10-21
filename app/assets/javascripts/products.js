$(document).ready(function(){

    jQuery(".best_in_place").best_in_place();
    
    $("#delete-img").click(function(e){
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

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();            
            reader.onload = function (e) {
                $('#target').attr('src', e.target.result);
                $('#target').show();
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#imgInp").change(function(){
        readURL(this);
    });

 });

