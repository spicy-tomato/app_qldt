class Pair<T, V> {
  T t;
  V v;

  Pair(this.t, this.v);

  T get first => t;

  V get second => v;

  set first(T t){
    this.t = t;
  }

  set second(V v){
    this.v = v;
  }
}
