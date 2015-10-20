$(document).ready(function(){
  
  $(document).ajaxSend(function(event, request, settings) {
      $('#loading-indicator').show();
    });

    $(document).ajaxComplete(function(event, request, settings) {
      $('#loading-indicator').hide();
    });
    
    $(window).scroll(function(){
      if ($(this).scrollTop() > 200) {
        $('.main-header').addClass("getFix");
      } else if($(this).scrollTop() < 200) {
        $('.main-header').removeClass("getFix");
      }
    });
});
