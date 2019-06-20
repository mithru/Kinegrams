//reference: http://www.it.uu.se/datordrift/maskinpark/skrivare/cups/
void printImage(String path) {  
  Process p = exec("lp", "-o", "media=Custom.4x6in", path); 
  try {
    int result = p.waitFor();
    println("the process returned " + result);
  } 
  catch (InterruptedException e) {
    println("error : " + e);
  }
}
