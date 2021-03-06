class FrontStarfield{
  protected Star stars[];
  protected int starcount;
  protected int strokeWeight;
  
  public FrontStarfield(int starcount, int strokeWeight){
    this.starcount = starcount;
    this.strokeWeight = strokeWeight;
    stars = new Star[starcount];
    for (int i = 0; i < starcount; i++) {
    stars[i] = new Star(random(width), random( height ), random( 10 ));
   }
  }

  public void draw() {
  strokeWeight(strokeWeight);
  for ( int i =0; i < starcount; i++) {
    stroke( 255,255,255 );
    point( stars[i].x, stars[i].y );
    stars[i].x -= stars[i].z;
    if (stars[i].x < 0) {
      stars[i] = new Star( width, random( height ), sqrt(random( 100 )));
    }
  }
 }
}