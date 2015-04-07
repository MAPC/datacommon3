// weave_synch.js
//
// by Matt Cloyd
// Metropolitan Area Planning Council
//
// Interface for simplifying the loading of
// Weave visualizations.

var DC = {};

DC.weaveConfig = {
  flashUrl:         "http://metrobostondatacommon.org/weave/weave.swf",
  expressInstaller: "expressInstall.swf",
  flashVersion:     "10.0.0",
  
  params: {
    quality:           "high",
    bgcolor:           "#FFFFFF",
    allowscriptaccess: "always",
    base:              "http://metrobostondatacommon.org/weave/",
    wmode:             "gpu"
  },

  flashvars: {
    allowDomain: '*'
  }
}

// console.log('DC.weaveConfig ready with:');
// console.dir(DC.weaveConfig);


DC.logger = {
  weaveStarted:  function (id) {
    // console.log('swfobject.embedSWF started loading visualization ' + id);
  },

  weaveFinished: function (id) {
    // console.log('swfobject.embedSWF finished loading visualization ' + id);
  },

  weaveReady:    function (weave) {
    // console.log('#weaveReady was called with the following instance:');
    console.dir(weave);
  }
};


// Beacuse #weaveReady, the callback invoked when any instance
// of the Weave SWF (weave.swf) Flash object, is scoped
// globally, the session state has to be available globally.

// Yes, this is bad design. I should be able to pass it
// whatever callback I want.

// To get around it, we set up DC.sessionStates. Any time
// someone loads a Weave visualization, the session state
// gets stashed in here, and it's given the ID of the
// visualization. When #weaveReady is called, it looks
// up the session state based on the ID of the Flash object
// that just loaded, which has the same ID as the visualization.

DC.sessionStates = {};
DC.weaves        = {};


// Use this when the visualization does not have a preview image
// yet. This function will start Weave directly, take a
// screenshot, and post it to the preview images.
DC.embedWeaveAndUpload = function ( dom_id, sessionstate, area_type, area_id, slug ) {
  // area_type: 'municipalities',  'subregions'
  // area_id:   'municipality_id', 'subregion_id'
  // slug:      'canton',          'metro-west'
  
  // console.log('embedWeaveAndUpload happening on ' + dom_id);
  
  var id = dom_id.split('-').pop();

  DC.sessionStates[id] = sessionstate;
  DC.embedWeave( $(dom_id) );

  // Wait 40 seconds, then POST the screenshot to 
  // be saved by the server.
  setTimeout(function () {
    DC.getBase64( id, function ( base64 ) {
      // var base64 = "data:image/png;base64," + base64
      var data_object = {
        id:   id,
        data: base64
      }      
      data_object[area_id] = slug

      $.ajax({
        type: "POST",
        url: "/" + area_type + "/" + slug + "/image",
        data: data_object,
        success: function (data) {
          // console.log( dom_id + ": Good news! I POSTed successfully." );
          // console.log( "The data was " + data + "." );
        },
        error: function (e) {
          // console.log( "Such error with " + dom_id + ", wow." );
          console.dir( e );
        }
      });
    });
  }, 37000);
}


DC.synchEmbedWeaveOnClick = function (dom_elem, sessionstate) {
  // console.log('embed fn listening to ' + dom_elem);
  
  $(dom_elem).on('click', function () {
    // console.log('synchEmbedWeaveOnClick triggered');

    var id = dom_elem.split('-').pop();

    DC.sessionStates[id] = sessionstate;
    DC.embedWeave( $(dom_elem) );
  });
}


DC.embedWeaveOnClick = function (dom_elem, geo, area_type) {
  // console.log('embed fn listening to ' + dom_elem);

  $(dom_elem).on('click', function () {
    // console.log('synchEmbedWeaveOnClick triggered');
    
    var id = dom_elem.split('-').pop();

    $.ajax({
      url: "/" + area_type + "/" + geo + "/state/" + id,
      dataType: 'xml'
    }).done(function( sessionstate ) {
      DC.sessionStates[id] = sessionstate;
      DC.embedWeave( $( dom_elem ) );
    });

  });
};


DC.embedWeave = function (dom_elem) {
  var id     = dom_elem.attr('id'),
      width  = dom_elem.innerWidth(),
      height = dom_elem.innerHeight();

  DC.logger.weaveStarted(id);

  swfobject.embedSWF(
    DC.weaveConfig.flashUrl,          // URL of flash script
    id,                               // id to populate with Flash
    width, height,                    // dimensions of SWF
    DC.weaveConfig.flashVersion,      // version
    DC.weaveConfig.expressInstaller,  // express install URL 
    DC.weaveConfig.flashvars,         // flashvars
    DC.weaveConfig.params,            // general Flash params (settings)
    {id: id, name: id},               // used in #getObjectById lookups
    DC.logger.weaveFinished(id)       // callback
  );   
};




DC.base64s = {};
DC.pngSpec = "data:image/png;base64,";

DC.getBase64 = function (weave_id, callback) {
  var base64 = DC.weaves[weave_id].evaluateExpression(null, 'getBase64Image(Application.application.visDesktop)',
                                                      null, ['weave.utils.BitmapUtils', 'mx.core.Application']);
  base64 = DC.pngSpec + base64
  DC.base64s[String(weave_id)] = base64;
  if (callback) {
    callback(base64);
  } else {
    return base64;
  }
}


DC.establishAllBase64 = function () {
  var visuals = $('.visual.preview');

  $.each(visuals, function (idx, div) {
    div.click();
    var weave_id = $(div).attr('id').split('-').pop();
    // console.log("weave_id", weave_id);

    setTimeout(function () {
      var base64 = DC.weaves[weave_id].evaluateExpression(null, 'getBase64Image(Application.application.visDesktop)', null, ['weave.utils.BitmapUtils', 'mx.core.Application']);
      DC.base64s[String(weave_id)] = DC.pngSpec + base64
    }, 40000 );
  });
}


DC.getAllBase64 = function () {
  return DC.base64s;
}


// var weaveReady = function (weave) {
//   var weave_id = weave.id.split('-').pop();
//   DC.weave     = weave;
  
//   DC.logger.weaveReady(weave);
//   DC.weaves[weave_id] = weave;
  
//   // IMPORTANT: Weave apparently cannot read XML session states
//   // directly. Instead of Weave checking if it's XML and doing
//   // the proper conversions, we are forced to do them here.

//   console.log(DC.sessionStates[weave_id])
//   console.log( String(DC.sessionStates[weave_id]) );

//   if (String(DC.sessionStates[weave_id]) === "[object XMLDocument]") {
//     var stringState = (new XMLSerializer()).serializeToString(DC.sessionStates[weave_id])
//         objectState = weave.convertSessionStateXMLToObject(stringState);

//     weave.setSessionState([], objectState);
//   } else {
//     weave.setSessionState([], DC.sessionStates[weave_id]);
//   }

//   weave.setSessionState(["WeaveProperties"], {
//     backgroundColor: "16777215", // 'white'
//     showCopyright:    false
//   });
// }