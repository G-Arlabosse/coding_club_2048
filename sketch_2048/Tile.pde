class Tile {
  int value;
  PVector position;
  PVector pixelPos;//top left
  boolean alreadyIncreased = false;
  boolean moving = false;

  color colour;
  PVector positionTo;
  PVector pixelPosTo;


  boolean deathOnImpact =false;

  Tile(int x, int y) {
    if (random(1)< 0.1) {
      value = 4;
    } else {
      value =2;
    }

    position = new PVector(x, y);
    positionTo = new PVector(x, y);

    pixelPos = new PVector(xoffset +x*200 + (x+1) *10, yoffset + y*200 + (y+1) *10);
    pixelPosTo = new PVector(xoffset + x*200 + (x+1) *10, yoffset + y*200 + (y+1) *10);

    setColour();
  }

  void show() {
    if (!deathOnImpact || moving) {
      fill(setColour());
      noStroke();
      rect(pixelPos.x, pixelPos.y, 200, 200);
      if (value < 8) {
        fill(100);
      } else {
        fill(240);
      }
      textAlign(CENTER, CENTER);
      textSize(50);
      text(value, pixelPos.x+100, pixelPos.y+100);
    }
  }

  void moveTo(PVector to) {
    positionTo = new PVector(to.x, to.y);
    pixelPosTo = new PVector(xoffset +to.x*200 + (to.x+1) *10, yoffset +to.y*200 + (to.y+1) *10);
    moving = true;
  }
  void moveToNow(PVector to) {
    position = new PVector(to.x, to.y);
    pixelPos = new PVector(xoffset +to.x*200 + (to.x+1) *10, yoffset +to.y*200 + (to.y+1) *10);
  }

  void move(int speed) {
    if (moving) {
      if (!teleport && dist(pixelPos.x, pixelPos.y, pixelPosTo.x, pixelPosTo.y) > speed) {
        PVector MoveDirection = new PVector(positionTo.x - position.x, positionTo.y - position.y); 
        MoveDirection.normalize();
        MoveDirection.mult(speed);
        pixelPos.add(MoveDirection);
      } else {
        moving = false;
        pixelPos = new PVector(pixelPosTo.x, pixelPosTo.y);
        position = new PVector(positionTo.x, positionTo.y);
      }
    }
  }
  
color setColour(){   
    ArrayList listColors = new ArrayList();
    int compteur = 0;
    int copyValue= value;
    listColors.add(#E4E1DC);
    listColors.add(#EFE7D8);
    listColors.add(#EED0A7);
    listColors.add(#E4AD63);
    listColors.add(#D5812F);
    listColors.add(#C14115);
    listColors.add(#EDEB92);
    listColors.add(#E9E775);
    listColors.add(#D9D64C);
    while (copyValue%2!=1){
      compteur+=1;
      copyValue=copyValue/2;
    }
    color colour=(color)listColors.get(compteur-1);
    return colour;
 }


  Tile clone() {
    Tile clone = new Tile(floor(position.x), floor(position.y));
    clone.value = value;
    clone.setColour();

    return clone;
  }
}
