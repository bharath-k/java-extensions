// import desco.systems.example;

package org.me;

public class myservicetest
{

    static
    {
        try
        {
            System.loadLibrary("example");
        }
        catch (UnsatisfiedLinkError e)
        {
            System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
            System.exit(1);
        }
    }

    public static void main(String argv[])
    {
        myservice service = example.get_service();
        System.out.println("String value is " + service.getstringEntry());

        myservice[] service_array = example.get_service_array();
        for(int i=0; i < service_array.length; i++)
        {
            service = service_array[i];
            System.out.println("String value is " + service.getstringEntry());
        }

        myservice service2  = example.fillup_service_proxy(0);
        System.out.println("String value is " + service.getstringEntry());


        myservice[] service_array2 = example.fillup_service_array_proxy(0);
        for(int i=0; i < service_array2.length; i++)
        {
            myservice service3 = service_array2[i];
            System.out.println("String value is " + service3.getstringEntry());
        }

    }
}
