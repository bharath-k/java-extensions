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
        myservice service = example.get_service();
        System.out.println("String value is " + service.getStringEntry());

        SWIGTYPE_p_p_myservice service_array = example.get_service_array();
        int count = example.get_count(service_array);
        for(int i=0; i < count; i++)
        {
            service = example.get_index_value(service_array, i);
            System.out.println("String value is " + service.getStringEntry());
        }

        container_service cs = example.fillup_service_proxy(0);
        service = cs.getService();
        System.out.println("String value is " + service.getStringEntry());

        container_service_array csarray = example.fillup_service_array_proxy(0);
        service_array = csarray.getServices();
        count = example.get_count(service_array);
        for(int i=0; i < count; i++)
        {
            service = example.get_index_value(service_array, i);
            System.out.println("String value is " + service.getStringEntry());
        }
    }
}
