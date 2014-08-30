// weave_synch.js
//
// by Matt Cloyd
// Metropolitan Area Planning Council
//
// Interface for simplifying the loading of
// Weave visualizations from synchronous
// session state

var DC = {};

DC.weave = {
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

console.log('DC.weave ready with:');
console.dir(DC.weave);


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



DC.embedWeaveOnClick = function (dom_elem, sessionstate) {
  $(dom_elem).on('click', function () {
    DC.embedWeave( $(this), sessionstate );
  });
};


var globalsessionstate = undefined;

var weaveReady = function (weave) {
  DC.logger.weaveReady(weave);
  weave.setSessionState([], globalsessionstate);
  weave.setSessionState(["WeaveProperties"], {
    backgroundColor: "16777215",
    showCopyright:    false
  });
}


DC.embedWeave = function (dom_elem, sessionstate) {
  var id     = dom_elem.attr('id'),
      width  = dom_elem.innerWidth(),
      height = dom_elem.innerHeight(),

      // Does the work of loading the session state for
      // the variable 'weave', which is the instance
      // of weave which has just been initialized.
      weaveReady = function(weave) {
        weave.setSessionState([], sessionstate);
        weave.setSessionState(["WeaveProperties"], {
          backgroundColor: "16777215",
          showCopyright:    false
        });
      };

  globalsessionstate = sessionstate;

  DC.logger.weaveStarted(id);

  swfobject.embedSWF(
    DC.weave.flashUrl,            // URL of flash script
    id,                           // id to populate with Flash
    width, height,                // dimensions of SWF
    DC.weave.flashVersion,        // version
    DC.weave.expressInstaller,    // express install URL 
    DC.weave.flashvars,           // flashvars
    DC.weave.params,              // general Flash params (settings)
    {id: id, name: id},           // TODO: Not sure where these are used.
    DC.logger.weaveFinished(id)   // callback
  );   
};