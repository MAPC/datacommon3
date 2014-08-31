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

console.log('DC.weaveConfig ready with:');
console.dir(DC.weaveConfig);


DC.logger = {
  weaveStarted:  function (id) {
    console.log('swfobject.embedSWF started loading visualization ' + id);
  },

  weaveFinished: function (id) {
    console.log('swfobject.embedSWF finished loading visualization ' + id);
  },

  weaveReady:    function (weave) {
    console.log('#weaveReady was called with the following instance:');
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

DC.embedWeaveOnClick = function (dom_elem, geo, area_type) {
  $(dom_elem).on('click', function () {
    
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
      width  = dom_elem.innerWidth()  - 10,
      height = dom_elem.innerHeight() - 10;

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



var weaveReady = function (weave) {
  var weave_id = weave.id.split('-').pop();
  DC.weave     = weave;
  
  DC.logger.weaveReady(weave);
  
  // IMPORTANT: Weave apparently cannot read XML session states
  // directly. Instead of Weave checking if it's XML and doing
  // the proper conversions, we are forced to do them here.

  var stringState = (new XMLSerializer()).serializeToString(DC.sessionStates[weave_id]);
  var objectState = weave.convertSessionStateXMLToObject(stringState);

  weave.setSessionState([], objectState);

  weave.setSessionState(["WeaveProperties"], {
    backgroundColor: "16777215", // 'white'
    showCopyright:    false
  });
}