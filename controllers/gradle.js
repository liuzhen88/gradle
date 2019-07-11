class GradleController {
  constructor(req, res){
    this.req = req;
  }
  build(){
    console.log(this.req.body);
  }
}

module.exports = GradleController;