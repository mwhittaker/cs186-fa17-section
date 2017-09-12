package edu.berkeley.cs186.database.io;

import java.nio.ByteBuffer;

public class Writer {
  public static void main(String[] args) {
    boolean wipe = true;
    PageAllocator allocator = new PageAllocator("data.bin", wipe);

    int pageNumber = allocator.allocPage();
    Page page = allocator.fetchPage(pageNumber);
    ByteBuffer buf = page.getByteBuffer();
    System.out.println("pageNumber = " + pageNumber);

    buf.putInt(1);
    buf.putInt(2);

    allocator.close();
  }
}
