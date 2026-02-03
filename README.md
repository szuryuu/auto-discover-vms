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

    Control Plane API  

    The Control Plane exposes a lightweight REST API on port `8080` to provide real-time observability into the service discovery process and the health of the mesh.

1.  List Discovered VMs  
    Retrieves the snapshot of Azure VMs currently discovered by the Control Plane and synchronized with Envoy.

    -   **Endpoint:** `/api/vms`
    -   **Method:** `GET`

    **Response Example:**
    ```json
    {
        "last_update": "2025-02-04T10:00:00Z",
        "total_vms": 2,
        "snapshot_version": 15,
        "vms": [
            {
                "name": "auto-discover-vms-app-0",
                "public_ip": "20.120.10.1",
                "private_ip": "10.1.1.4"
            },
            {
                "name": "auto-discover-vms-app-1",
                "public_ip": "20.120.10.2",
                "private_ip": "10.1.1.5"
            }
        ]
    }
    ```
2.  Health Check  
    Provides the operational status of the Control Plane, including uptime and the last successful discovery timestamp.  

    -   **Endpoint:** `/api/health`
    -   **Method** `GET`

    **Response Example:**
    ```json
    {
        "status": "healthy",
        "uptime": 3600.5,
        "total_vms": 2,
        "last_update": "2025-02-04T10:05:00Z"
    }   
    ```
3.  Trigger Discovery
    Forces an immediate polling cycle to the Azure API. This is useful for instantly registering new instances after a scaling event, bypassing the default polling interval (30s).

    -   **Endpoint:** `/api/discovery/trigger`
    -   **Method:** `POST`

    **Response Example:**  
    ```json
    {
        "message": "Discovery triggered",
        "note": "Check logs for results"
    }
    ```

**Example Usage:**  
```bash
# Check system health
curl -s http://<CONTROL_PLANE_IP>:8080/api/health | jq

# Force a discovery update
curl -X POST http://<CONTROL_PLANE_IP>:8080/api/discovery/trigger
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
