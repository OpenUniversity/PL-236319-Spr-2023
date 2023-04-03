signature KERNEL1D_SIG = sig
  type source
  type target
  val kernel : source -> source -> source -> target
  val default : source -> source
end;

signature KERNEL2D_SIG = sig
  type source
  type target
  val kernel : source * source * source -> source * source * source -> source * source * source -> target
  val default : source -> source
end;