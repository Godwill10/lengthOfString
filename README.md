# lengthOfString

 Name: Godwill Afolabi
 findlength.asm

 Finds the length of a string using Assembly MIPS instructions

int strlen( char *string) {
  int length = 0;
  while( *(string + length) != NULL) {
    length++;
  }
  return( length);
}
