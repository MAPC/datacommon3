// weave_synch.js
//
// by Matt Cloyd
// Metropolitan Area Planning Council
//
// Interface for simplifying the loading of
// Weave visualizations.

const DEBUG = true;

var debug_log = function (message, type) {
  var message = "Weave: " + message
  if (DEBUG) {
    switch(type) {
      case 'dir':
        console.dir( message )
      break
      case 'warn':
        console.warn( message )
      break
      case 'error':
        console.error( message )
      break
      default: console.log( message );
    }
  }
}


debug_log("DEBUG is TRUE. All debug_log messages will print.")

/*

  DataCommon Weave Object

    - default Weave configuration
    - logging events
    - utilities for uploading images

*/

var DC  = {};

const XML      = (new XMLSerializer());
const PNG_SPEC = "data:image/png;base64,";

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


// In the DOM, do:
visuals = {}

$(document).on('ready', function() {  
  $('.visual').each( function(i) {
    v = new Visual( $(this).attr('id') )
    visuals[v.id] = v
  });
});

// var v = new Visual('#9')

var getLocation = function() {
  var parser = document.createElement('a');
  parser.href = window.location;
  return parser
}

var getHost = function() {
  return getLocation().host
}

var getProtocol = function() {
  return getLocation().protocol
}


var Visual = function (id, weave_object, sessionstate) {
  this.id           = /(\d+)/.exec(id)[0] // Get any digits
  this.container    = $('#' + id)         // The div containing the image and eventually Flash
  this.weave_object = weave_object        // The Flash object
  this.sessionstate = sessionstate        // The JSON/XML representing the visualization
  this.png_string   = ''                  // The Base64 string that encodes a PNG

  this.width  = this.container.innerWidth()
  this.height = this.container.innerHeight()

  this.upload_png_url   = getProtocol() + '//' + getHost() + '/visualizations/' + this.id + '/upload_image'
  this.sessionstate_url = getProtocol() + '//' + getHost() + '/visualizations/' + this.id + '/session_state.json'

  var that = this

  this.preload_session_state( function(state) {
    that.to_json()  // Assert session state is JSON
    
    // Embed flash on click
    that.container.on('click', function () {
      that.embed_swf();
    });

  });
}


// Return JSON sessionstate, regardless of whether it's stored as JSON
Visual.prototype.to_json = function(callback) {
  if ( String(this.sessionstate) === "[object XMLDocument]" ) {
    this.sessionstate = weave.convertSessionStateXMLToObject(
      XML.serializeToString( this.sessionstate )
    );
  }
  return (callback) ? callback(this.sessionstate) : this.sessionstate
}


// Embed the Flash object into the container
Visual.prototype.embed   = function() {
  // If there's no sessionstate, get the sessionstate from a remote URL.
  // Embed the JSON version of the sessionstate
  this.embed_swf( this.set_session_state() )
}


Visual.prototype.set_session_state = function () {
  this.weave_object = $('object#' + this.id)
  this.weave_object.setSessionState([], this.sessionstate);
}

Visual.prototype.embed_swf = function (callback) {
  var that = this;  // get a local binding

  swfobject.embedSWF(
    DC.weaveConfig.flashUrl,          // URL of Flash script
    that.id,                          // ID of container to populate with Flash
    that.width, that.height,          // Dimensions of SWF to load
    DC.weaveConfig.flashVersion,      // Flash version
    DC.weaveConfig.expressInstaller,  // Express install URL (quicker Flash load?)
    DC.weaveConfig.flashvars,         // flashvars
    DC.weaveConfig.params,            // General Flash settings
    { id: that.id, name: that.id },   // Used by #getObjectById
    debug_log(that.id + ': Loading SWF') // callback
  )
  return (callback) ? callback() : undefined
}


Visual.prototype.preload_session_state = function (callback) {
  // If there is sessionstate, return it.
  // If there is not, get it and return it.
  var that = this
  if (this.sessionstate === undefined || this.sessionstate === '') {
    $.ajax({
      url:  that.sessionstate_url,
      dataType: 'json',
      success: function (data) {
        that.sessionstate = data;
        debug_log("Good news! I GETted the session state from " + that.sessionstate_url + ".");
        return that.sessionstate;
      },
      error: function (error) {
        console.error( "An error occurred when GETting " + that.sessionstate_url + ".");
        console.dir( error );
        return false;
      }
    });
    return (callback) ? callback(this.sessionstate) : this.sessionstate
  }
}


var weaveReady = function (weave) {

  id = $(weave).attr('id')
  visuals[id].weave_object = weave

  weave.setSessionState(["WeaveProperties"], {
    backgroundColor: "16777215", // 'white'
    showCopyright:    false
  });

  weave.setSessionState([], visuals[id].sessionstate);
}



// Get the PNG string from the Flash object
// Visual.prototype.to_img  = function(callback) { 
//   base_64_string = this.weave_object.evaluateExpression(
//     null,
//     'getBase64Image(Application.application.visDesktop)',
//     null, 
//     ['weave.utils.BitmapUtils', 'mx.core.Application']
//   );

//   this.png_string = PNG_SPEC + base_64_string
//   if (callback) {
//     callback( this.png_string )
//   } else {
//     return this.png_string
//   }
// }


// Upload the PNG string to a remote URL
// TODO: Set visualization preview to have class .visual, #id = object id
// Visual.prototype.upload_img = function() {
//   $.ajax({
//     type: "POST",
//     url:  this.upload_png_url,
//     data: this.to_img(),
//     success: function (data) {
//       debug_log("Good news! I POSTed successfully to " + this.upload_png_url + ".");
//       debug_log(data, 'dir');
//       return data
//     },
//     error: function (error) {
//       console.error( "An error occurred when uploading to " + this.upload_png_url + ".");
//       console.dir( error );
//       return false
//     }
//   });
// }

debug_log('DC.weaveConfig contains:');
debug_log(DC.weaveConfig, 'dir');