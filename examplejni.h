/*
 * Author: Bharath Kumaran
 * Licensing: GNU General Public License (http://www.gnu.org/copyleft/gpl.html)
 * Description: example header file.
 */

struct container_service {
    int retCode;
    MYService *service;
};
typedef struct container_service Container_Service;

// This container is to return the result to .NET.
struct container_service_array {
int retCode;
MYService **services;
};

typedef struct container_service_array Container_Service_Array;

/* The main method wrappers */
Container_Service *fillup_service_proxy(int fail);
Container_Service_Array *fillup_service_array_proxy(int fail);