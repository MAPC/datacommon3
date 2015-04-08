// weave_synch.js
//
// by Matt Cloyd
// Metropolitan Area Planning Council
//
// Interface for simplifying the loading of
// Weave visualizations.

var debug_log = function (message, type) {
  var prefix = "Weave: "
  if (DEBUG) {
    switch(type) {
      case 'dir':
        console.dir( message )
      break
      case 'warn':
        console.warn( prefix + message )
      break
      case 'error':
        console.error( prefix + message )
      break
      default: console.log( prefix + message );
    }
  }
}

const DEBUG = true;
debug_log("DEBUG is TRUE. All debug_log messages will print.")

const XML      = (new XMLSerializer());
const PNG_SPEC = "data:image/png;base64,";

// Check for 'missing.(png|jpg|jpeg)' in path
const MISSING_IMAGE_REGEX = /(\/missing\.(png|jpe?g))/i;

/*

  DataCommon Weave Object

    - default Weave configuration
    - logging events
    - utilities for uploading images

*/

var DC  = {};

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


// Visuals is sort of like the Visualization model, used for lookup.
var Visuals = {}

var embed_on_click = function (selector) {
  // Allow a selector to be passed in, but
  // default to '.visual' as the visualization selector
  selector = (selector) ? selector : '.visual';
  $(selector).each( function() {
    visual = new Visual( $(this).attr('id') ); // Create a Visual from the DOM element
    Visuals[visual.id] = visual;               // Add the new Visual to the 'model'
  });
}

var embed_immediately = function (selector) {
  // Delegate to #embed_on_click, then click them all.
  // ...So clever.
  embed_on_click( selector );
  $(selector).each ( function() {
    $(this).trigger('click');
  })
}

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

var getLikelyId = function (which) {
  var path = getLocation().pathname.split('/'),
     which = (which) ? which : 1;
  return path[path.length - which]
}


var Visual = function (id, sessionstate, pathname, format, params) {
  this.id           = String(id).replace('#', '') // Remove hash
  this.container    = $('#' + id)         // The div containing the image and eventually Flash
  this.weave_object = undefined           // The Flash object, starts out undefined
  this.sessionstate = sessionstate        // The JSON/XML representing the visualization
  this.png_string   = ''                  // The Base64 string that encodes a PNG
  this.pathname     = (pathname) ? pathname : '/visualizations'
  this.format       = (format)   ? format   : 'json'
  this.params       = ((params) ? '?' + params : '')
  this.needs_upload = undefined // Updated in check_needs_upload

  this.width  = this.container.innerWidth();
  this.height = this.container.innerHeight();

  var that = this;

  this.preload_session_state( function(state) {  
    // Embed flash on click
    that.container.on('click', function () {
      that.embed_swf();
    });
  });

  this.check_needs_upload();
}


Visual.prototype.upload_png_url = function () {
  return getProtocol() + '//' + getHost() + this.pathname + '/' + this.id + '/upload_image' + this.params
}

Visual.prototype.sessionstate_url = function () {
  return getProtocol() + '//' + getHost() + this.pathname + '/' + this.id + '/session_state.' + this.format + this.params
}


Visual.prototype.check_needs_upload = function (callback) {
  var src   = String( this.container[0]['src'] );
  var match = MISSING_IMAGE_REGEX.exec(src)
  
  if (match) {
    this.needs_upload = true;
  }
  return (callback) ? callback(this.needs_upload) : this.needs_upload
}

// TODO
Visual.prototype.upload_if_necessary = function (wait_time, callback) {
  // Default to waiting for 7 seconds after #weaveReady.
  var wait_time = (wait_time) ? wait_time : 7000;

  var that = this;
  if (this.needs_upload) { 
    debug_log('It needs to be uploaded. Waiting ' + (wait_time / 1000) + ' seconds.')
    setTimeout( function () { that.upload_img() }, wait_time );
  }
  return (callback) ? callback('TODO') : 'TODO'
}

// TODO: Provide option to re-upload regardless of image presence

// Return JSON sessionstate, regardless of whether it's stored as JSON
Visual.prototype.to_json = function(callback) {
  if ( String(this.sessionstate) === "[object XMLDocument]" ) {
    this.sessionstate = this.weave_object.convertSessionStateXMLToObject(
      XML.serializeToString( this.sessionstate )
    );
  }
  return (callback) ? callback(this.sessionstate) : this.sessionstate
}


Visual.prototype.set_session_state = function () {
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

  $('.pre-weave').hide();
  return (callback) ? callback() : undefined
}


Visual.prototype.preload_session_state = function (callback) {
  // If there is sessionstate, return it.
  // If there is not, get it and return it.
  if (String(this.id) == 'new') {
    debug_log('This is a new visualization: bailing out and returning.')
    return (callback) ? callback(this.sessionstate) : this.sessionstate
  }

  var that = this
  if (this.sessionstate === undefined || this.sessionstate === '') {
    $.ajax({
      url:  that.sessionstate_url(),
      dataType: that.format,
      success: function (data) {
        that.sessionstate = data;
        debug_log("Good news! I GETted the session state from " + that.sessionstate_url());
        return that.sessionstate;
      },
      error: function (error) {
        console.error( "An error occurred when GETting " + that.sessionstate_url());
        console.dir( error );
        return false;
      }
    });
    return (callback) ? callback(this.sessionstate) : this.sessionstate
  }
}


Visual.prototype.weave_ready = function (weave) {
  // Set the weave_object if one is passed
  if (weave !== undefined) {
    this.weave_object = weave;
  }

  var that = this;

  this.sessionstate = this.to_json(function () {
    that.weave_object.setSessionState(["WeaveProperties"], {
      backgroundColor: "16777215", // 'white'
      showCopyright:    false
    });

    that.weave_object.setSessionState([], that.sessionstate);
  });

  this.upload_if_necessary();
}


// This is the only function outside the object-oriented paradigm.
// weaveReady is called when a Weave Flash object is embedded.
// This just delegates to Visual#weave_ready to do the work.

var weaveReady = function (weave) {
  // Get the ID of the Weave object, which corresponds
  // to the ID of the visualization.
  var id = $(weave).attr('id')
  Visuals[id].weave_ready(weave)   // Delegate to the visual
}



// Get the PNG string from the Flash object
Visual.prototype.to_img  = function(callback) { 
  base_64_string = this.weave_object.evaluateExpression(
    null,
    'getBase64Image(Application.application.visDesktop)',
    null, 
    ['weave.utils.BitmapUtils', 'mx.core.Application']
  );

  this.png_string = base_64_string
  if (callback) {
    callback( this.png_string )
  } else {
    return this.png_string
  }
}


// Upload the PNG string to a remote URL
Visual.prototype.upload_img = function(callback) {
  var that = this;
  $.ajax({
    type: "POST",
    url:  that.upload_png_url(),
    data: { data: String(that.to_img()) },
    success: function (data) {
      debug_log("Good news! I POSTed successfully to " + that.upload_png_url());
      return (callback) ? callback(data) : data
    },
    error: function (error) {
      debug_log( "An error occurred when uploading to " + that.upload_png_url(), 'error');
      debug_log( error );
      return (callback) ? callback(error) : error
    }
  });
}




debug_log('DC.weaveConfig contains:');
debug_log(DC.weaveConfig, 'dir');
