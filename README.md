# Azure Auto Discover VMs

Implementing a dynamic Service Mesh using Envoy Proxy to automatically discover and load balance Azure Virtual Machine IP addresses via a custom Control Plane.

---

## Features

-   **Azure Service Discovery**  
    Leverages the Azure SDK for Go to automatically discover backend Virtual Machines based on resource tags and metadata, eliminating the need for manual IP configuration or static lists.
-   **Custom Envoy Control Plane (xDS)**
    Implementing a lightweight Control Plane in Go that provides dynamic configuration directly to the Envoy proxy via the gRPC xDS protocol.
-   **Seamless Scaling & Observability**  
    Enables zero-downtime scaling by instantly routing traffic to new instances without proxy restarts, paired with a built-in REST API that provides real-time visibility into the discovery status and health of backend nodes.

## Infrastructure

| INFRA | Details |
| :--- | :--- |
| **Network** | NSG port 80, 8080, 22 (SSH) |
| **Compute** | Control Plane Vm (go-control-plane), Envoy LB Vm (envoy proxy), Backend Vm (apps vm) |

## API Documentation

1.  Endpoint    : {IP_ADDR}/api/vms
    Method      : GET
    Description : Returns the list of active Azure VMs currently known to the Control Plane and synchronized with Envoy.

    Response Example    :  
    ```JSON
    {
	    "last_update": "2025-01-02T10:00:00Z",
	    "total_vms": 2,
	    "snapshot_version": 5,
	    "vms": [
	    {
		    "name": "app-vm-0",
		    "public_ip": "20.1.2.3",
		    "private_ip": "10.1.1.4"
	    }
	    ]
    };
    ```
2.  Endpoint    : {IP_ADDR}/api/health
    Method      : GET
    
    Response Example    :   
    ```JSON
    {
        "status": "healthy",
        "uptime": 3600,
        "total_vms": 2
    }
    ```
3.  Endpoint    : {IP_ADDR}/api/discovery/trigger
    Method      : POST
    Description : Useful for forcing an update immediately after scaling events.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
