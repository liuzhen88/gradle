class BaseContorller {
  constructor(req, res){
    this.res = res;
  }
  responseNoContent(){
    this.res.sendStatus(204);
  }
}

module.exports = BaseContorller;