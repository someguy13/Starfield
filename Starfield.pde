Particle[] p = new Particle[100];
Bullet b = new Bullet();
boolean shoot = false;
void setup()
{
	size(600,600);	
	for(int i = 0; i < p.length; i++){
		p[i] = new NormalParticle();
	}	
	p[0] = new JumboParticle();
	p[1] = new OddballParticle();
	frameRate(40);
}
void draw()
{
	background(0);
	for(int i = 0; i < p.length; i++){
		p[i].show();
		p[i].move();
	}
	if(shoot){
		b.show();
		b.move();
	}
	strokeWeight(10);
	noFill();
	stroke(102);
	ellipse(width/2,height/2,width - 100,height - 100);
	beginShape();
	vertex(width/2 - 50,height/2 - 100);
	vertex(width/2 + 50,height/2 - 100);	
	vertex(width/2 + 100, height/2 - 50);
	vertex(width/2 + 100, height/2 + 50);
	vertex(width/2 + 50,height/2 + 100);
	vertex(width/2 - 50,height/2 + 100);
	vertex(width/2 - 100, height/2 + 50);
	vertex(width/2 - 100, height/2 - 50);
	endShape(CLOSE);

	for (int i = 0; i < 4 ; i ++){
		pushMatrix();
		translate(width/2,height/2);
		rotate(PI/2 * i);
		line(-50,-100,-95,-230);
		line(50,-100,95,-230);
		popMatrix(); 
	}
	strokeWeight(300);
	stroke(7,13,18);
	ellipse(width/2,height/2,width + 200 , height + 200);

	strokeWeight(5);
	stroke(102);
	fill(0,0,255);
	beginShape();
	vertex(220,460);
	vertex(380,460);
	vertex(395,545);
	vertex(205,545);
	endShape(CLOSE);
	strokeWeight(1);
	fill(7,13,18);
	
	rect(225,500,20,65,5);
	rect(355,500,20,65,5);
	rect(290,565,20,75);
	rect(225,545,150,20);

}
class NormalParticle implements Particle
{
	double myY,mySpeed,myAccel,myAngle,mySize,sizeInc;
	NormalParticle()
	{
		myY = (Math.random()*375 + 25);
		mySpeed = (Math.random() + 5);
		myAccel = 1.03;
		sizeInc = 1.05;
		myAngle = (Math.random() * TWO_PI);
		mySize = 1;
	}

	public void move(){
		myY += mySpeed; 
		mySpeed *= myAccel;
		mySize *= sizeInc;
		if(myY > 425){
			myY = (Math.random()*375 + 25);
			mySpeed = (Math.random() + 2);
			myAngle = (Math.random() * TWO_PI);
			mySize = 1;
		}
	}
	public void show(){
		fill(255);
		pushMatrix();
		translate(width/2,height/2);
		rotate((float)(myAngle));
		ellipse(0,(float)myY,(float)mySize,(float)mySize);
		popMatrix();
	}
}
interface Particle
{
	public void move();
	public void show();

}
class OddballParticle implements Particle
{
	double myY, myAngle, mySpeed, myAccel,mySize;
	boolean myDir;
	OddballParticle(){
		myY = 300;
		myAngle = 45;
		mySpeed = Math.random() + 10;
		myAccel = 1.03;
		myDir = true;
		mySize = Math.random() * 20 + 30;
	}
	public void show(){
			fill(255);
			pushMatrix();
			translate(width/2,height/2);
			if(myDir){
				rotate((float)myAngle);
			}
			else  {
				rotate((float)myAngle * -1);
			}
			falcon(0,myY,mySize);
			popMatrix();
			
	}
	public void move(){
		myY += mySpeed;
		mySpeed *= myAccel;
		if(myY > 10800 && myDir) {
			myY = -300;
			myDir = false;
			mySpeed = Math.random() + 10;
			mySize = Math.random() * 20 + 30;
		}
		else if(myY > 10800 && !myDir){
			myY = -300;
			myDir = true;
			mySpeed = Math.random() + 10;
			mySize = Math.random() * 20 + 30;
		}

	}
}
class JumboParticle extends NormalParticle
{
	JumboParticle(){
		myAccel = 1.03;
		sizeInc = 1.1;
		
	}

	public void move(){
		super.move();
	}
	public void show(){
		pushMatrix();
		translate(width/2,height/2);
		rotate((float)(myAngle));
		asteroid(0,myY,mySize);
		popMatrix();
	}
}

class Bullet
{
	float myY, mySize;
	Bullet(){
		myY = -300;
		mySize = 100;
	}
	void show(){
		fill(0,255,0);
		pushMatrix();
		translate(width/2,height/2);
		rotate(60);
		rect(0,myY,mySize/5,mySize,10);
		popMatrix();
		pushMatrix();
		translate(width/2,height/2);
		rotate(-60);
		rect(-20,myY,mySize/5,mySize,10);
		popMatrix();
	}
	void move(){
		myY += 10;
		mySize-=4;
		if(mySize < 0){
			myY = -200;
			mySize = 100;
			shoot = false;
		}
	}
}
void mousePressed(){
	redraw();
	shoot = true;
}
void asteroid(double x,double y,double size){
	double aSize = size/5;
	fill(120);
	ellipse((float)x,(float)y,(float)size,(float)size);
	fill(33);
	ellipse((float)(x - size/4.5), (float)(y - size/4), (float)aSize,(float)aSize);
	ellipse((float)(x + size/4.5), (float)(y - size/6), (float)aSize,(float)aSize);
	ellipse((float)(x - size/10), (float)y, (float)aSize,(float)aSize);
	ellipse((float)(x - size/3.5), (float)(y + size/5), (float)aSize,(float)aSize);
	ellipse((float)(x + size/10), (float)(y + size/3.5), (float)aSize,(float)aSize);
	ellipse((float)(x + size/3), (float)(y + size/6), (float)aSize,(float)aSize);
}

void falcon(int x, double y, double size){
	y = -y;
	fill(170);
  	stroke(0);
  	rect((float)y-(float)size*1.06,(float)x-(float)size/5,(float)size,(float)size/10);
  	rect((float)y-(float)size*1.06,(float)x+(float)size/10,(float)size,(float)size/10);
  	triangle((float)y,(float)x-(float)size/5,(float)y,(float)x-(float)size/2,(float)y-(float)size,(float)x-(float)size/5);
  	triangle((float)y,(float)x+(float)size/5,(float)y,(float)x+(float)size/2,(float)y-(float)size,(float)x+(float)size/5);
  	ellipse((float)y,(float)x,(float)size,(float)size);
  	arc((float)y,(float)x,(float)size,(float)size,-PI/4,PI/4,PIE);
  	arc((float)y,(float)x,(float)size-(float)size/10,(float)size-(float)size/10,PI*4/9,PI*5/9,PIE);
  	arc((float)y,(float)x,(float)size-(float)size/10,(float)size-(float)size/10,-PI*5/9,-PI*4/9,PIE);
  	beginShape();
  	vertex((float)y - (float)size/50,(float)x - (float)size * 0.14);
  	vertex((float)y - (float)size * 0.3,(float)x - (float)size * 0.66);
  	vertex((float)y - (float)size * 0.56,(float)x - (float)size * 0.66);
  	vertex((float)y - (float)size * 0.6,(float)x - (float)size * 0.62);
  	vertex((float)y - (float)size * 0.6,(float)x - (float)size/2);
  	vertex((float)y - (float)size * 0.56,(float)x - (float)size * 0.46);
  	vertex((float)y - (float)size * 0.4,(float)x - (float)size * 0.46);
  	vertex((float)y - (float)size * 0.12,(float)x - (float)size/50);
  	endShape(CLOSE);
  	ellipse((float)y,(float)x,(float)size * 0.3,(float)size * 0.3);
  	rect((float)y - (float)size * 0.6,(float)x - (float)size/10,(float)size * 0.44,(float)size/5); 
  	fill(0);
  	stroke(255);
  	ellipse((float)y + (float)size * 0.32,(float)x,(float)size/10,(float)size/10);
  	ellipse((float)y + (float)size * 0.22,(float)x,(float)size/10,(float)size/10);
  	ellipse((float)y + (float)size/5,(float)x + (float)size/10,(float)size/10,(float)size/10);
  	ellipse((float)y + (float)size/5,(float)x - (float)size/10,(float)size/10,(float)size/10);
  	ellipse((float)y + (float)size * 0.26,(float)x + (float)size * 0.16,(float)size/10,(float)size/10);
  	ellipse((float)y + (float)size * 0.26,(float)x - (float)size * 0.16,(float)size/10,(float)size/10);
}

