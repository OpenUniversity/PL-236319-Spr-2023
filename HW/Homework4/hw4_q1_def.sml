use "hw2_q3.sml";
use "hw3_q1.sml";
use "hw3_q2.sml";

local
	fun toCell false = empty
	  | toCell true = alive;
in
fun is_alive_bool (x1, x2, x3) (y1, y2, y3) (z1, z2, z3) = 
	case (
		is_alive 
			(toCell x1, toCell x2, toCell x3) 
			(toCell y1, toCell y2, toCell y3) 
			(toCell z1, toCell z2, toCell z3)) of empty => false | alive => true
end;
			
fun run f 0 _ = ()
  | run f times  delay = (f(); OS.Process.system ("sleep " ^ Real.toString delay); run f (times  - 1) delay);
			
val start_frame = [
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                     ***  ***  ***  ***   *   ***                       ", 
"                       *    *  *      *  **   * *                       ", 
"                     ***  ***  ***  ***   *   ***                       ", 
"                     *      *  * *    *   *     *                       ", 
"                     ***  ***  ***  ***  ***  ***                       ",  
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        ", 
"                                                                        "];