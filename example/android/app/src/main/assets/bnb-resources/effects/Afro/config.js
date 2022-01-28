function Effect() {
    var self = this;

    this.meshes = [
        { file: "afro_2.bsm2", anims: [
            { a: "CINEMA_4D_Main", t: 1000 },
        ] },
        { file: "afro_1.bsm2", anims: [
            { a: "CINEMA_4D_Main", t: 1000 },
        ] },
        { file: "afro_3.bsm2", anims: [
            { a: "CINEMA_4D_Main", t: 1000 },
        ] },
    ];

    this.play = function() {
        var now = (new Date()).getTime();
        for(var i = 0; i < self.meshes.length; i++) {
            if(now > self.meshes[i].endTime) {
                self.meshes[i].animIdx = (self.meshes[i].animIdx + 1)%self.meshes[i].anims.length;
                Api.meshfxMsg("animOnce", i, 0, self.meshes[i].anims[self.meshes[i].animIdx].a);
                self.meshes[i].endTime = now + self.meshes[i].anims[self.meshes[i].animIdx].t;
            }
        }
    };

    this.init = function() {
        Api.meshfxMsg("spawn", 5, 0, "!glfx_FACE");
        Api.meshfxMsg("spawn", 0, 0, "afro_2.bsm2");
        Api.meshfxMsg("spawn", 1, 0, "afro_1.bsm2");
        Api.meshfxMsg("spawn", 2, 0, "afro_3.bsm2");
        Api.meshfxMsg("spawn", 3, 0, "afro_4.bsm2");
        Api.meshfxMsg("spawn", 4, 0, "Morph.bsm2");

        for(var i = 0; i < self.meshes.length; i++) {
            self.meshes[i].animIdx = -1;
            self.meshes[i].endTime = 0;
        }

        self.faceActions = [self.play];
        Api.playSound("afro.ogg",true,1);
        Api.showRecordButton();
    };

    this.restart = function() {
        Api.meshfxReset();
        Api.stopSound("afro.ogg");
        self.init();
    };

    this.faceActions = [];
    this.noFaceActions = [];

    this.videoRecordStartActions = [];
    this.videoRecordFinishActions = [];
    this.videoRecordDiscardActions = [this.restart];
}

configure(new Effect());