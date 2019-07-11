const BaseContorller = require("./base");
const shell = require("shelljs");

class GradleController extends BaseContorller {
  constructor(req, res){
    super(req, res);
    this.req = req;
  }
  build(){
    console.log(this.req.body);
    let EventName = this.req.body.event_name;
    let ref = this.req.body.ref;
    if(EventName != "tag_push"){
      console.log("无对应event");
      this.responseNoContent();
      return false;
    }
    if(!ref){
      this.responseNoContent();
      return false;
    }
    let tagId = ref.replace("refs/tags/", "");
    //let defaultBranch = this.req.body.project.default_branch;
    if(!tagId){
      console.error("tagId not found");
      return false;
    }
    this.responseNoContent();
    let data = shell.exec("sh build.sh " + tagId);
    if(data.code != 0){
      // send email
    }
  }
}

module.exports = GradleController;