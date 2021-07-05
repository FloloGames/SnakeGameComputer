//My own little Vector Class
class VecInt {  
  int x, y;

  VecInt(VecInt v) {
    this.x = v.x;
    this.y = v.y;
  }
  VecInt(int x, int y) {
    this.x = x;
    this.y = y;
  }
  VecInt copy() {
    return new VecInt(x, y);
  }
  void add(VecInt v) {
    x += v.x;
    y += v.y;
  }
  void set(VecInt v) {
    x = v.x;
    y = v.y;
  }
  void set(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
