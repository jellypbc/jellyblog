function Ball(r, p, v) {
  this.radius = r;
  this.point = p;
  this.vector = v;
  this.maxVec = 2.5;
  this.numSegment = Math.floor(r / 3 + 2);
  this.boundOffset = [];
  this.boundOffsetBuff = [];
  this.sidePoints = [];
  this.path = new Path({
    fillColor: {
      hue: (Math.random() * 30) + 130,
      saturation: 1,
      brightness: 1
    },
    blendMode: 'lighter'
  });

  for (var i = 0; i < this.numSegment; i ++) {
    this.boundOffset.push(this.radius);
    this.boundOffsetBuff.push(this.radius);
    this.path.add(new Point());
    this.sidePoints.push(new Point({
        angle: 360 / this.numSegment * i,
        length: 1
    }));
  }
}

Ball.prototype = {
  iterate: function() {
      this.checkBorders();
      if (this.vector.length > this.maxVec)
          this.vector.length = this.maxVec;
      this.point += this.vector;
      this.updateShape();
  },

  checkBorders: function() {
      var size = view.size;
      if (this.point.x < -this.radius)
          this.point.x = size.width + this.radius;
      if (this.point.x > size.width + this.radius)
          this.point.x = -this.radius;
      if (this.point.y < -this.radius)
          this.point.y = size.height + this.radius;
      if (this.point.y > size.height + this.radius)
          this.point.y = -this.radius;
  },

  updateShape: function() {
      var segments = this.path.segments;
      for (var i = 0; i < this.numSegment; i ++)
          segments[i].point = this.getSidePoint(i);

      this.path.smooth();
      for (var i = 0; i < this.numSegment; i ++) {
          if (this.boundOffset[i] < this.radius / 4)
              this.boundOffset[i] = this.radius / 4;
          var next = (i + 1) % this.numSegment;
          var prev = (i > 0) ? i - 1 : this.numSegment - 1;
          var offset = this.boundOffset[i];
          offset += (this.radius - offset) / 15;
          offset += ((this.boundOffset[next] + this.boundOffset[prev]) / 2 - offset) / 3;
          this.boundOffsetBuff[i] = this.boundOffset[i] = offset;
      }
  },

  react: function(b) {
    var dist = this.point.getDistance(b.point);
    if (dist < this.radius + b.radius && dist != 0) {
      var overlap = this.radius + b.radius - dist;
      var direc = (this.point - b.point).normalize(overlap * 0.015);
      this.vector += direc;
      b.vector -= direc;

      this.calcBounds(b);
      b.calcBounds(this);
      this.updateBounds();
      b.updateBounds();
    }
  },

  getBoundOffset: function(b) {
      var diff = this.point - b;
      var angle = (diff.angle + 180) % 360;
      return this.boundOffset[Math.floor(angle / 360 * this.boundOffset.length)];
  },

  calcBounds: function(b) {
    for (var i = 0; i < this.numSegment; i ++) {
      var tp = this.getSidePoint(i);
      var bLen = b.getBoundOffset(tp);
      var td = tp.getDistance(b.point);
      if (td < bLen) {
          this.boundOffsetBuff[i] -= (bLen  - td) / 2;
      }
    }
  },

  getSidePoint: function(index) {
      return this.point + this.sidePoints[index] * this.boundOffset[index];
  },

  updateBounds: function() {
      for (var i = 0; i < this.numSegment; i ++)
          this.boundOffset[i] = this.boundOffsetBuff[i];
  }
};

  //--------------------- main ---------------------

var balls = [];
var numBalls = 3;
for (var i = 0; i < numBalls; i++) {
  var position = Point.random() * view.size;
  var vector = new Point({
    angle: 360 * Math.random(),
    length: Math.random() * 10
  });
  var radius = Math.random() * 30 + 10;
  balls.push(new Ball(radius, position, vector));
}

function onFrame() {
  for (var i = 0; i < balls.length - 1; i++) {
    for (var j = i + 1; j < balls.length; j++) {
      balls[i].react(balls[j]);
    }
  }
  for (var i = 0, l = balls.length; i < l; i++) {
    balls[i].iterate();
  }
}

const isMobile = () => {
  const vendor = navigator.userAgent || navigator.vendor || window.opera;
  return !!(
    /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(
      vendor
    ) ||
    /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw-(n|u)|c55\/|capi|ccwa|cdm-|cell|chtm|cldc|cmd-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc-s|devi|dica|dmob|do(c|p)o|ds(12|-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(-|_)|g1 u|g560|gene|gf-5|g-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd-(m|p|t)|hei-|hi(pt|ta)|hp( i|ip)|hs-c|ht(c(-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i-(20|go|ma)|i230|iac( |-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|-[a-w])|libw|lynx|m1-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|-([1-8]|c))|phil|pire|pl(ay|uc)|pn-2|po(ck|rt|se)|prox|psio|pt-g|qa-a|qc(07|12|21|32|60|-[2-7]|i-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h-|oo|p-)|sdk\/|se(c(-|0|1)|47|mc|nd|ri)|sgh-|shar|sie(-|m)|sk-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h-|v-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl-|tdg-|tel(i|m)|tim-|t-mo|to(pl|sh)|ts(70|m-|m3|m5)|tx-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas-|your|zeto|zte-/i.test(
      vendor.substr(0, 4)
    )
  );
};

if (isMobile() === false){
  $('.header-remove').remove();
  $('.header').removeClass('hidden');
}

$( document ).on('turbolinks:load', function() {
  window.location.reload()
})