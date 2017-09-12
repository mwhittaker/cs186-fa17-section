package edu.berkeley.cs186.database.io;

import java.nio.ByteBuffer;

public class Reader {
  public static void main(String[] args) {
    boolean wipe = false;
    PageAllocator allocator = new PageAllocator("data.bin", wipe);

    Page page = allocator.fetchPage(0);
    ByteBuffer buf = page.getByteBuffer();

    System.out.println(buf.getInt());
    System.out.println(buf.getInt());

    allocator.close();
  }
}
