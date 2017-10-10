import java.util.Iterator;
import java.util.NoSuchElementException;

public class IntIterator implements Iterator<Integer> {
  private int x;
  private int low;
  private int high;

  public IntIterator(int low, int high) {
    this.x = low;
    this.low = low;
    this.high = high;
  }

  @Override
  public boolean hasNext() {
    return x < high;
  }

  @Override
  public Integer next() {
    if (!hasNext()) {
      throw new NoSuchElementException();
    }

    int tmp = x;
    x++;
    return tmp;
  }

  public static void main(String[] args) {
    Iterator<Integer> iter = new IntIterator(0, 10);
    while (iter.hasNext()) {
      System.out.println(iter.next());
    }
  }
}
