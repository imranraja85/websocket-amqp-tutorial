 (function(){
  SimpleSock = function(url) {
    ws = new WebSocket(url);
    var that = this;
    this.bindings = {};
    
    ws.onmessage = function(message){
      resp = JSON.parse(message.data);
      that.bindings[resp.event](resp.data);
    }
  }
    
  SimpleSock.prototype.bind = function(event, callback){
    this.bindings[event] = callback;
  }
})();
