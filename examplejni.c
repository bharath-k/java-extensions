/*
 * Author: Bharath Kumaran
 * Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
 * Description: example header file.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "example.h"
#include "examplejni.h"

Container_Service *fillup_service_proxy(int fail)
{
    // Call the real fillup_service here.
    MYService *service = NULL;
    int ret = fillup_service(fail, &service);
    //Create new container_service.
    Container_Service *retcontainer = (Container_Service *)malloc(sizeof(Container_Service*));
    retcontainer->retCode = ret;
    retcontainer->service = service;
    return retcontainer;
}

Container_Service_Array *fillup_service_array_proxy(int fail)
{
    // Call the real fillup_service here.
    MYService **service_array;
    int ret = fillup_service_array(fail, &service_array);
    //Create new container_service.
    Container_Service_Array *retcontainer = (Container_Service_Array *)malloc(sizeof(Container_Service_Array *));
    retcontainer->retCode = ret;
    retcontainer->services = service_array;
    return retcontainer;
}