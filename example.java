/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 1.3.40
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package org.me;

public class example {
  public static org.me.myservice get_service() {
    return exampleJNI.get_service();
}

  public static org.me.myservice[] get_service_array() {
    return exampleJNI.get_service_array();
}

  public static org.me.myservice fillup_service_proxy(int fail) {
    return exampleJNI.fillup_service_proxy(fail);
}

  public static org.me.myservice[] fillup_service_array_proxy(int fail) {
    return exampleJNI.fillup_service_array_proxy(fail);
}

}