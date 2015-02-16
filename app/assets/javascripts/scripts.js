
$(document).ready(function(){/* affix the navbar after scroll below header */
$('#nav').affix({
      offset: {
        top: $('header').height()-$('#nav').height()
      }
});

/* highlight the top nav as scrolling occurs */
$('body').scrollspy({ target: '#nav' })

/* smooth scrolling for scroll to top */
$('.scroll-top').click(function(){
  $('body,html').animate({scrollTop:0},1000);
})

/* smooth scrolling for nav sections */
$('#nav .navbar-nav li>a').click(function(){
  var link = $(this).attr('href');
  var posi = $(link).offset().top+20;
  $('body,html').animate({scrollTop:posi},700);
})

/* google maps */
google.maps.event.addDomListener(window, 'load', initialize);

function initialize() {

  /* position Kyiv */
  var latlng = new google.maps.LatLng(50.430193, 30.520009);

  var mapOptions = {
    center: latlng,
    scrollWheel: false,
    zoom: 13
  };

  var marker = new google.maps.Marker({
    position: latlng,
    url: '/',
    animation: google.maps.Animation.DROP
  });

  var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  marker.setMap(map);

};
/* end google maps -----------------------------------------------------*/
});

$(document).on("click", ".free_spot, .booked_spot", function () {
     $("#lesson_booked_date").mask("99/99/9999",{placeholder:"mm/dd/yyyy"});
     var TimeslotId = $(this).data('id');
     var selected_date = TimeslotId.split("_")[1];
     var selected_hrs = Number(TimeslotId.split("_")[0].split(":")[0]);
     var selected_min = TimeslotId.split("_")[0].split(":")[1];
     var am_pm = "AM";
     if (selected_hrs>12) {
        selected_hrs = selected_hrs - 12;
        am_pm = "PM";
      } else if (selected_hrs == 12) { am_pm = "PM"}
      var selected_time = selected_hrs.toString()+":"+selected_min+" "+am_pm;
     $(".modal-body #lesson_booked_date").val(selected_date.substring(6,8)+'/'+selected_date.substring(4,6)+'/'+selected_date.substring(0,4));
     $(".modal-body #lesson_booked_time").val(selected_time);
     /* Datepicker */
     $('#lesson_booked_date').datepicker('update');
     $("#lesson_booked_time").clockpick({
        starthour : 8,
        endhour : 22,
        showminutes : true,
        minutedivisions: 2
        });
});


