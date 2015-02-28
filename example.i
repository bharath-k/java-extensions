%include "typemaps.i"

%module example

%{
#include "example.h"
%}


%inline %{

struct container_service {
int retCode;
MYService *service;
};

typedef struct container_service Container_Service;

Container_Service *fillup_service_proxy(int fail)
{
    // Call the real fillup_service here.
    MYService *service;
    int ret = fillup_service(fail, &service);
    //Create new container_service.
    Container_Service *retcontainer = (Container_Service *)malloc(sizeof(Container_Service*));
    retcontainer->retCode = ret;
    retcontainer->service = service;
    return retcontainer;
}

// This container is to return the result to .NET.
struct container_service_array {
int retCode;
MYService **services;
};

typedef struct container_service_array Container_Service_Array;

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

%}

%include "example.h"

// This container is to return the result to .NET.
struct container_service {
int retCode;
MYService *service;
};

typedef struct container_service Container_Service;

// Now create a proxy to fillup_service.
Container_Service *fillup_service_proxy(int fail);

//------------------------------------------------------

// This container is to return the result to .NET.
struct container_service_array {
int retCode;
MYService **services;
};

typedef struct container_service_array Container_Service_Array;

// Now create a proxy to fillup_service.
Container_Service_Array *fillup_service_array_proxy(int fail);

// TODO: Add destroy methods for Container_Service and Container_Service_Array
