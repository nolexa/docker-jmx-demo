public class Hammer {
  public static void main(String[] args) {
    System.out.println("I'm a hammer. I'll be banging forever!");
    while (true) {
      try {
        System.out.print(".");
        Thread.sleep(3000);
      } catch (InterruptedException e) {
        break;
      }
    }
  }
}
