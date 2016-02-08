var io = require('socket.io')();
var nicknames = [];
io.on('connection', function(socket){

   function contains(data) {
        if(data ===null || data === '')
		    return true;
            for (var i in nicknames) {
                if (nicknames[i] === data) {
                    return true;
                }
            }
            return false;
        }



  socket.on('nickname', function(data){
  if(!contains(data))
    nicknames.push(data);
	socket.nickname = data;
	io.emit('nicknames', nicknames);
    console.log("Nicknames on connect: "+nicknames); 
  });
  
  
  socket.on('user message', function(data){
    io.emit('user message'+data.channel, {nickname: socket.nickname,message:data.message});   
  }); 
  
  
  socket.on('disconnect', function(){
    if(!socket.nickname) return;
	if(nicknames.indexOf(socket.nickname) > -1){
	   nicknames.splice(nicknames.indexOf(socket.nickname),1);
	}
	io.emit('nicknames', nicknames);
	console.log("Nicknames on disconnect: "+nicknames);
  });
});
io.listen(3000);
console.log("server running on port 3000...");