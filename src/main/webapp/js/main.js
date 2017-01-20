$(function() {
      var nav = $('.fixed_nav');
      var navTop = nav.offset().top+100;
      var navHeight = nav.height()+10;
      var showFlag = false;
      nav.css('top', -navHeight+'px');
      $(window).scroll(function () {
          var winTop = $(this).scrollTop();
          if (winTop >= navTop) {
              if (showFlag == false) {
                  showFlag = true;
                  nav
                      .addClass('fixed')
                      .stop().animate({'top' : '0px'}, 500);
              }
          } else if (winTop <= navTop) {
              if (showFlag) {
                  showFlag = false;
                  nav.stop().animate({'top' : -navHeight+'px'}, 500, function(){
                      nav.removeClass('fixed');
                  });
              }
          }
      });
  });

  $(function(){
      var headerHight = 50;
     $('a[href^=#]').click(function() {
        var speed = 400;
        var href= $(this).attr("href");
        var target = $(href == "#" || href == "" ? 'html' : href);
        var position = target.offset().top-headerHight;
        $('body,html').animate({scrollTop:position}, speed, 'swing');
        return false;
     });
  });



$('.hour, .minute, .second').data('plus-deg', 0)
calcTime();
$('#clock').addClass('aminate');
var int = setInterval(calcTime, 1000);
function calcTime () {
  var d = new Date();
  var h = d.getHours();
  rotate($('.hour'),  ((h > 12 ? h - 12 : h)*30)-90);
  rotate($('.minute'), (d.getMinutes()/*0-59*/*6)-90);
  rotate($('.second'), (d.getSeconds()/*0-59*/*6)-90);
}
function rotate ($object, deg) {
  var original_deg = deg;
  if(deg != $object.data('deg')){
    if(deg == -90) {
      $object.data('plus-deg', $object.data('plus-deg')+360);
    }
    deg += $object.data('plus-deg');
    $object.css({
      '-webkit-transform' : 'rotate('+deg+'deg)',
      '-moz-transform' : 'rotate('+deg+'deg)',  
      '-ms-transform' : 'rotate('+deg+'deg)',  
      '-o-transform' : 'rotate('+deg+'deg)',  
      'transform' : 'rotate('+deg+'deg)',  
      'zoom' : 1
    });
    $object.data('deg', original_deg);
  }
}
/* ================================================ /*
/*                                                  /* 
/*                   Clock Source                   /*
/*    http://codepen.io/martingrand/details/aAldc   /*
/*                                                  /*
/* ================================================ */