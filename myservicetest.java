// import desco.systems.example;

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
        String service = example.get_service();
        System.out.println("String value is " + service);

        String[] service_array = example.get_service_array();
        for(int i=0; i < service_array.length; i++)
        {
            service = service_array[i];
            System.out.println("String value is " + service);
        }

        String service2  = example.fillup_service_proxy(0);
        System.out.println("String value is " + service2);

        service_array = example.fillup_service_array_proxy(0);
        for(int i=0; i < service_array.length; i++)
        {
            service = service_array[i];
            System.out.println("String value is " + service);
        }
    }
}
