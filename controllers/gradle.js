const BaseContorller = require("./base");
const shell = require("shelljs");

class GradleController extends BaseContorller {
  constructor(req, res){
    super(req, res);
    this.req = req;
  }
  build(){
    console.log(this.req.body);

    if(this.req.body.object_kind != 'tag_push') {
      this.responseNoContent();
      return false;
    }

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
    let projectName = this.req.body.project.name;
    if(!tagId){
      console.error("tagId not found");
      return false;
    }
    this.responseNoContent();

    


    let data = shell.exec(`sh build.sh ${tagId} ${projectName}`);
    console.log('--------执行结果----------')
    console.log(data);
    console.log('------------------')
    if(data.code != 0){
      // send email
    }
  }
}

module.exports = GradleController;