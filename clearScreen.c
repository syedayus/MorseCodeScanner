
void clear_words(int x, int y, short letter){
	volatile short *vga_char=(volatile short*)(0x09000000 + (y<<7) + (x<<0));
	*vga_char=letter;
	
}

/* use write_pixel to set entire screen to black (does not clear the character buffer) */
void clear_screen() {
  int x, y;

  for (x=0; x<80; x++){
	for (y = 0; y < 60; y++){
	  clear_words(x,y,32);
	}  
  }
}
