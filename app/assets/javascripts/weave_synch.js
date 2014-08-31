// weave_synch.js
//
// by Matt Cloyd
// Metropolitan Area Planning Council
//
// Interface for simplifying the loading of
// Weave visualizations from synchronous
// session state

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


var globalsessionstate = undefined;

DC.embedWeaveOnClick = function (dom_elem) {
  $(dom_elem).on('click', function () {
    
    $.ajax({
      url: "/municipalities/belmont/state/1",
      dataType: 'xml'
    }).done(function( sessionstate ) {
      globalsessionstate = sessionstate;
      DC.embedWeave( $( dom_elem ) );
    });

  });
};


DC.embedWeave = function (dom_elem) {
  var id     = dom_elem.attr('id'),
      width  = dom_elem.innerWidth() - 10,
      height = dom_elem.innerHeight() - 10;

  DC.logger.weaveStarted(id);

  swfobject.embedSWF(
    DC.weaveConfig.flashUrl,            // URL of flash script
    id,                           // id to populate with Flash
    width, height,                // dimensions of SWF
    DC.weaveConfig.flashVersion,        // version
    DC.weaveConfig.expressInstaller,    // express install URL 
    DC.weaveConfig.flashvars,           // flashvars
    DC.weaveConfig.params,              // general Flash params (settings)
    {id: id, name: id},           // TODO: Not sure where these are used.
    DC.logger.weaveFinished(id)   // callback
  );   
};



var weaveReady = function (weave) {
  DC.weave = weave;
  
  DC.logger.weaveReady(weave);
  console.log("globalsessionstate", globalsessionstate);

  var convertedState = (new XMLSerializer()).serializeToString(globalsessionstate);

  console.log("convertedState", convertedState);
  var newstate = weave.convertSessionStateXMLToObject(convertedState);

  console.log("newstate", newstate);

  DC.weave.setSessionState([], newstate);
  
  // weave.setSessionState([], globalsessionstate);
  weave.setSessionState(["WeaveProperties"], {
    backgroundColor: "16777215",
    showCopyright:    false
  });
}